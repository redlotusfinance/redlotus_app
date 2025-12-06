const express = require('express');
const router = express.Router();
const { submitForm, getAllSubmissions } = require('../controllers/submissionController');
const { protect } = require('../middleware/authMiddleware');

// Public route for submission
router.post('/submit-form', submitForm);

// Protected route for viewing submissions
router.get('/submissions', protect, getAllSubmissions);

module.exports = router;
