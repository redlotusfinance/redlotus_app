const Bank = require('../models/bank');

// @desc    Get matched banks for a user
// @route   POST /api/banks/match
// @access  Public
const getMatchedBanks = async (req, res) => {
  try {
    const { loanPurpose, monthlyIncome, existingLoans } = req.body;

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

    // 3. Filter by Eligibility Formula
    // Formula: eligibleIncome = NetSalary * (LTV / 100) - All EMIs - (0.05 * CreditCardOutstanding)
    // Rule: eligibleIncome >= 3000
    
    const eligibleBanks = potentialBanks.filter(bank => {
      const bankLTV = bank.ltv || 0; 
      const eligibleIncome = (monthlyIncome * (bankLTV / 100)) - totalEMIs - (0.05 * totalCreditCardOutstanding);
      
      // Optional: You can log this for debugging if needed
      // console.log(`Bank: ${bank.name}, LTV: ${bankLTV}, Eligible Income: ${eligibleIncome}`);
      
      return eligibleIncome >= 3000;
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
