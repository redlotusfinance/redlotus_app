const mongoose = require('mongoose');

const bankSchema = new mongoose.Schema({
  name: { type: String, required: true, unique: true },
  logoUrl: { type: String, required: true },
  supportedLoanTypes: [{ type: String, enum: ['Personal', 'Home', 'Mortgage', 'Business'] }],
  minIncome: { type: Number, default: 0 },
  maxLoanAmount: { type: Number, default: 1000000 },
  interestRate: {
    min: { type: Number, required: true },
    max: { type: Number, required: true },
  },
  approvalRate: { type: Number, required: true, min: 0, max: 100 },
  keyFeatures: [String],
  applicationUrl: { type: String, required: true },
  tagline: { type: String }
});

module.exports = mongoose.model('Bank', bankSchema);
