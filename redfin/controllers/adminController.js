const Bank = require('../models/bank');

// @desc    Add a new bank
// @route   POST /api/admin/banks
// @access  Private
const addBank = async (req, res) => {
  try {
    const bank = new Bank(req.body);
    await bank.save();
    res.status(201).json({ message: 'Bank added successfully', data: bank });
  } catch (error) {
    res.status(400).json({ message: 'Error adding bank', error: error.message });
  }
};

// @desc    Get all banks
// @route   GET /api/admin/banks
// @access  Private
const getAllBanks = async (req, res) => {
  try {
    const banks = await Bank.find();
    res.status(200).json({ data: banks });
  } catch (error) {
    res.status(500).json({ message: 'Error fetching banks', error: error.message });
  }
};

// @desc    Get a single bank by ID
// @route   GET /api/admin/banks/:id
// @access  Private
const getBankById = async (req, res) => {
  try {
    const bank = await Bank.findById(req.params.id);
    if (!bank) {
      return res.status(404).json({ message: 'Bank not found' });
    }
    res.status(200).json({ data: bank });
  } catch (error) {
    res.status(500).json({ message: 'Error fetching bank', error: error.message });
  }
};

// @desc    Update a bank
// @route   PUT /api/admin/banks/:id
// @access  Private
const updateBank = async (req, res) => {
  try {
    const bank = await Bank.findByIdAndUpdate(req.params.id, req.body, { new: true, runValidators: true });
    if (!bank) {
      return res.status(404).json({ message: 'Bank not found' });
    }
    res.status(200).json({ message: 'Bank updated successfully', data: bank });
  } catch (error) {
    res.status(400).json({ message: 'Error updating bank', error: error.message });
  }
};

// @desc    Delete a bank
// @route   DELETE /api/admin/banks/:id
// @access  Private
const deleteBank = async (req, res) => {
  try {
    const bank = await Bank.findByIdAndDelete(req.params.id);
    if (!bank) {
      return res.status(404).json({ message: 'Bank not found' });
    }
    res.status(200).json({ message: 'Bank deleted successfully' });
  } catch (error) {
    res.status(500).json({ message: 'Error deleting bank', error: error.message });
  }
};


module.exports = {
  addBank,
  getAllBanks,
  getBankById,
  updateBank,
  deleteBank,
};
