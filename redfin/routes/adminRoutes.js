const express = require('express');
const router = express.Router();
const { 
  addBank,
  getAllBanks,
  getBankById,
  updateBank,
  deleteBank
} = require('../controllers/adminController');
const { protect } = require('../middleware/authMiddleware');

// Apply the 'protect' middleware to all routes in this file
router.use(protect);

// Route to get all banks and add a new bank
router.route('/banks')
  .get(getAllBanks)
  .post(addBank);

// Route to get, update, and delete a specific bank by ID
router.route('/banks/:id')
  .get(getBankById)
  .put(updateBank)
  .delete(deleteBank);

module.exports = router;
