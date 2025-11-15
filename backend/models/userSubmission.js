const mongoose = require('mongoose');

const userSubmissionSchema = new mongoose.Schema({
  // Personal Info
  customerName: { type: String, required: true },
  dateOfBirth: { type: Date, required: true },
  loanPurpose: { type: String, required: true },
  profession: { type: String, required: true },
  email: { type: String, required: true },
  phoneNumber: { type: String, required: true },
  gender: { type: String, required: true },
  maritalStatus: { type: String, required: true },

  // Address Info
  currentAddressLine1: { type: String, required: true },
  currentAddressLine2: { type: String },
  currentCity: { type: String, required: true },
  currentDistrict: { type: String, required: true },
  currentState: { type: String, required: true },
  currentPinCode: { type: String, required: true },
  currentLandmark: { type: String },
  isPermanentSameAsCurrent: { type: Boolean, default: false },
  permanentAddressLine1: { type: String },
  // ... other permanent address fields

  // Financial Info
  monthlyIncome: { type: Number, required: true },
  monthlyCommission: { type: Number },
  hasExistingLoans: { type: Boolean, default: false },
  personalLoanOutstanding: { type: Number },
  // ... other loan fields
  hasOverdraft: { type: Boolean, default: false },
  overdraftAmount: { type: Number },
  
  submissionDate: { type: Date, default: Date.now }
});

module.exports = mongoose.model('UserSubmission', userSubmissionSchema);
