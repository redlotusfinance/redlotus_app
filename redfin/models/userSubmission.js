const mongoose = require('mongoose');

const userSubmissionSchema = new mongoose.Schema({
  // Personal Info - Removed 'required' to prevent validation errors
  customerName: { type: String },
  dateOfBirth: { type: Date },
  spouseName: { type: String },
  fatherName: { type: String },
  motherName: { type: String },
  loanPurpose: { type: String },
  loanType: { type: String },
  profession: { type: String },
  companyName: { type: String },
  firmType: { type: String },
  selfEmployedDesignation: { type: String },
  email: { type: String },
  phoneNumber: { type: String },
  gender: { type: String },
  maritalStatus: { type: String },

  // Address Info
  residenceType: { type: String },
  rentDuration: { type: String },
  currentAddressLine1: { type: String },
  currentAddressLine2: { type: String },
  currentCity: { type: String },
  currentDistrict: { type: String },
  currentState: { type: String },
  currentPinCode: { type: String },
  currentLandmark: { type: String },
  isPermanentSameAsCurrent: { type: Boolean, default: false },
  
  // Permanent Address Fields
  permanentAddressLine1: { type: String },
  permanentAddressLine2: { type: String },
  permanentLandmark: { type: String },
  permanentTaluka: { type: String },
  permanentCity: { type: String },
  permanentDistrict: { type: String },
  permanentState: { type: String },
  permanentPinCode: { type: String },
  
  // Office Address Info
  officeLandmark: { type: String },
  officeTaluka: { type: String },
  officeCity: { type: String },
  officeDistrict: { type: String },
  officeState: { type: String },
  officePinCode: { type: String },

  // Financial Info
  // Using default: 0 handles missing data, but removing 'required' is safer for 'null' values
  monthlyIncome: { type: Number, default: 0 },
  monthlyCommission: { type: Number, default: 0 },
  cibilScore: { type: String },
  
  hasExistingLoans: { type: Boolean, default: false },
  existingLoans: [{
    loanType: String,
    bankName: String,
    amount: Number
  }],
  
  hasOverdraft: { type: Boolean, default: false },
  overdraftAmount: { type: Number, default: 0 },
  
  // Bouncing Details
  hasOverdue: { type: Boolean, default: false },
  overdueLoanType: { type: String },
  overdueAmount: { type: Number, default: 0 },
  bouncingStatus: { type: String },
  bouncingMonths: { type: String },
  bouncingDays: { type: Number, default: 0 },
  
  panNumber: { type: String },

  submissionDate: { type: Date, default: Date.now }
});

module.exports = mongoose.model('UserSubmission', userSubmissionSchema);
