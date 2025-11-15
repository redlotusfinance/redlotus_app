const UserSubmission = require('../models/userSubmission');

// @desc    Submit a new user form
// @route   POST /api/user/submit-form
// @access  Public
const submitForm = async (req, res) => {
  try {
    const submission = new UserSubmission(req.body);
    await submission.save();
    res.status(201).json({ message: 'Form submitted successfully', data: submission });
  } catch (error) {
    res.status(400).json({ message: 'Error submitting form', error: error.message });
  }
};

module.exports = {
  submitForm,
};
