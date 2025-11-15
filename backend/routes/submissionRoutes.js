const express = require('express');
const router = express.Router();
const { submitForm } = require('../controllers/submissionController');

router.post('/submit-form', submitForm);

module.exports = router;
