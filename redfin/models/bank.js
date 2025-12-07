const mongoose = require('mongoose');

const bankSchema = new mongoose.Schema({
  name: { type: String, required: true, unique: true },
  logoUrl: { type: String, required: true },
  supportedLoanTypes: [{ 
    type: String, 
    enum: [
      'Personal Loan',
      'Home loan',
      'Loan Against Property',
      'Mortgage loan',
      'Business Loan',
      'Working Capital Loan',
      'Machinery Loan',
      'Construction Loan',
      'Solar Loan',
      'Marriege',
      'New Business Set-up',
      'Loan consolidation',
      'Credit card Payment',
      'Land Purchase',
      'Home Construction',
      'Land buy+Construction',
      'Business Expension',
      'Two wheeler',
      'New Car',
      'Old Car Finance',
      'SME Loan',
    ] 
  }],
  minIncome: { type: Number, default: 0 },
  maxLoanAmount: { type: Number, default: 1000000 },
  // New Fields
  minLoanAmount: { type: Number, default: 0 },
  minCibilScore: { type: Number, default: 0 },
  multiplier: { type: Number, default: 1 }, 
  
  interestRate: {
    min: { type: Number, required: true },
    max: { type: Number, required: true },
  },
  ltv: { type: Number, required: true, min: 0, max: 100 }, 
  keyFeatures: [String],
  applicationUrl: { type: String, required: true },
  tagline: { type: String },
  minAge: { type: Number, default: 18 },
  maxAge: { type: Number, default: 65 }
});

module.exports = mongoose.model('Bank', bankSchema);
