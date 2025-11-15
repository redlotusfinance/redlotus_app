const Bank = require('../models/bank');

// @desc    Get matched banks for a user
// @route   GET /api/banks/match
// @access  Public
const getMatchedBanks = async (req, res) => {
  try {
    const { loanPurpose, monthlyIncome } = req.query;

    if (!loanPurpose || !monthlyIncome) {
      return res.status(400).json({ message: 'Loan purpose and monthly income are required.' });
    }

    const banks = await Bank.find({
      supportedLoanTypes: loanPurpose,
      minIncome: { $lte: monthlyIncome },
    });

    // Rank the banks
    const rankedBanks = banks.sort((a, b) => {
      // 1. Highest approval rate
      if (b.approvalRate !== a.approvalRate) {
        return b.approvalRate - a.approvalRate;
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
