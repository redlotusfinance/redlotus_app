const mongoose = require('mongoose');

const userSubmissionSchema = new mongoose.Schema({
  // Personal Info - Only making the most critical fields required
  customerName: { type: String, required: true },
  dateOfBirth: { type: Date },
  loanPurpose: { type: String },
  profession: { type: String },
  email: { type: String, required: true },
  phoneNumber: { type: String },
  gender: { type: String },
  maritalStatus: { type: String },

  // Address Info
  currentAddressLine1: { type: String },
  currentAddressLine2: { type: String },
  currentCity: { type: String },
  currentDistrict: { type: String },
  currentState: { type: String },
  currentPinCode: { type: String },
  currentLandmark: { type: String },
  isPermanentSameAsCurrent: { type: Boolean, default: false },
  permanentAddressLine1: { type: String },
  // ... other permanent address fields

  // Financial Info - Income is the most critical for matching
  monthlyIncome: { type: Number, required: true },
  monthlyCommission: { type: Number },
  hasExistingLoans: { type: Boolean, default: false },
  personalLoanOutstanding: { type: Number },
  carLoanOutstanding: { type: Number },
  creditCardOutstanding: { type: Number },
  otherLoanOutstanding: { type: Number },
  hasOverdraft: { type: Boolean, default: false },
  overdraftAmount: { type: Number },
  
  submissionDate: { type: Date, default: Date.now }
});

module.exports = mongoose.model('UserSubmission', userSubmissionSchema);
