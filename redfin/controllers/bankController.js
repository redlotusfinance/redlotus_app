const Bank = require('../models/bank');

// Helper to calculate age
const calculateAge = (dobString) => {
  if (!dobString) return 0;
  const dob = new Date(dobString);
  const diff_ms = Date.now() - dob.getTime();
  const age_dt = new Date(diff_ms);
  return Math.abs(age_dt.getUTCFullYear() - 1970);
};

// Helper to parse CIBIL score from range string
const parseCibilScore = (cibilString) => {
  if (!cibilString) return 0;
  if (cibilString === '750+') return 750;
  if (cibilString === '720-749') return 720;
  if (cibilString === '700-719') return 700;
  if (cibilString === '650-700') return 650;
  if (cibilString === 'less than 650') return 0;
  if (cibilString === '-1') return -1;
  if (cibilString === '0') return 0;
  return 0; // Default
};

// @desc    Get matched banks for a user
// @route   POST /api/banks/match
// @access  Public
const getMatchedBanks = async (req, res) => {
  try {
    const { 
      loanPurpose, 
      monthlyIncome, 
      existingLoans,
      cibilScore,
      dateOfBirth,
      residenceType,
      rentDuration
    } = req.body;

    if (!loanPurpose || monthlyIncome === undefined) {
      return res.status(400).json({ message: 'Loan purpose and monthly income are required.' });
    }

    // 1. Calculate Financial Obligations
    let totalEMIs = 0;
    let totalCreditCardOutstanding = 0;

    if (existingLoans && Array.isArray(existingLoans)) {
      existingLoans.forEach(loan => {
        const amount = Number(loan.amount) || 0;
        if (loan.loanType === 'Credit Card') {
          totalCreditCardOutstanding += amount;
        } else {
          totalEMIs += amount;
        }
      });
    }

    // 2. Fetch Potential Banks (Basic Filtering)
    const potentialBanks = await Bank.find({
      supportedLoanTypes: loanPurpose,
      minIncome: { $lte: monthlyIncome },
    });

    // 3. Filter by Advanced Eligibility
    const userAge = calculateAge(dateOfBirth);
    const userCibil = parseCibilScore(cibilScore);
    
    const eligibleBanks = potentialBanks.filter(bank => {
      // A. Eligible Income Check
      const bankLTV = bank.ltv || 0; 
      const eligibleIncome = (monthlyIncome * (bankLTV / 100)) - totalEMIs - (0.05 * totalCreditCardOutstanding);
      if (eligibleIncome < 3000) return false;

      // B. CIBIL Score Check
      // If user has -1 or 0 (new to credit), bank might have specific rules, 
      // but usually banks require a minimum score if set. 
      // Assuming '0' minCibilScore in bank means no minimum.
      if (bank.minCibilScore > 0 && userCibil < bank.minCibilScore) return false;

      // C. Age Check
      if (bank.minAge && userAge < bank.minAge) return false;
      if (bank.maxAge && userAge > bank.maxAge) return false;

      // D. Residence & Rent Duration Check
      if (residenceType === 'Rented') {
        // Fail if rent duration is "less than Year"
        if (rentDuration === 'less than Year') return false;
      }

      return true;
    });

    // 4. Rank the Banks
    const rankedBanks = eligibleBanks.sort((a, b) => {
      // 1. Highest LTV (Loan To Value)
      if (b.ltv !== a.ltv) {
        return b.ltv - a.ltv;
      }
      // 2. Lowest interest rate
      return a.interestRate.min - b.interestRate.min;
    });

    res.status(200).json({ data: rankedBanks });
  } catch (error) {
    res.status(500).json({ message: 'Error fetching matched banks', error: error.message });
  }
};

module.exports = {
  getMatchedBanks,
};
