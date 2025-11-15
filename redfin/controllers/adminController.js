const Bank = require('../models/bank');

// @desc    Add a new bank
// @route   POST /api/admin/banks
// @access  Private (for now, public for testing)
const addBank = async (req, res) => {
  try {
    const bank = new Bank(req.body);
    await bank.save();
    res.status(201).json({ message: 'Bank added successfully', data: bank });
  } catch (error) {
    res.status(400).json({ message: 'Error adding bank', error: error.message });
  }
};

module.exports = {
  addBank,
};
