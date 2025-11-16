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
    // Log the detailed validation error to the server console
    console.error('Mongoose Validation Error:', error.toString()); 

    // Send a more detailed error response back to the client
    res.status(400).json({ 
      message: 'Error submitting form due to validation issues.', 
      error: error.message,
      details: error.errors // This will contain field-specific error messages
    });
  }
};

module.exports = {
  submitForm,
};
