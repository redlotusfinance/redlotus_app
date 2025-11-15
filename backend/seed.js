const mongoose = require('mongoose');
const Bank = require('./models/bank');

const dbURI = 'mongodb://localhost:27017/fincare';

const sampleBanks = [
  {
    name: 'Capital One',
    logoUrl: 'https://logos-world.net/wp-content/uploads/2020/04/Capital-One-Logo.png',
    supportedLoanTypes: ['Personal', 'Business'],
    minIncome: 50000,
    maxLoanAmount: 50000,
    interestRate: { min: 3.99, max: 8.99 },
    approvalRate: 85,
    keyFeatures: ['No annual fee', 'Travel rewards', 'Cash back'],
    applicationUrl: 'https://www.capitalone.com/',
    tagline: 'Best for travel rewards'
  },
  {
    name: 'Wells Fargo',
    logoUrl: 'https://logos-world.net/wp-content/uploads/2020/05/Wells-Fargo-Logo.png',
    supportedLoanTypes: ['Personal', 'Home', 'Mortgage'],
    minIncome: 60000,
    maxLoanAmount: 200000,
    interestRate: { min: 4.5, max: 9.5 },
    approvalRate: 80,
    keyFeatures: ['Wide range of loan options', 'Physical branch locations'],
    applicationUrl: 'https://www.wellsfargo.com/',
    tagline: 'Great for in-person service'
  },
   {
    name: 'Citibank',
    logoUrl: 'https://logos-world.net/wp-content/uploads/2020/04/Citibank-Logo.png',
    supportedLoanTypes: ['Personal', 'Mortgage', 'Business'],
    minIncome: 70000,
    maxLoanAmount: 150000,
    interestRate: { min: 5.0, max: 10.0 },
    approvalRate: 90,
    keyFeatures: ['Global banking services', 'Competitive interest rates'],
    applicationUrl: 'https://www.citi.com/',
    tagline: 'Excellent for international banking'
  }
];

mongoose.connect(dbURI, { useNewUrlParser: true, useUnifiedTopology: true })
  .then(async () => {
    console.log('MongoDB connected');
    await Bank.deleteMany({});
    await Bank.insertMany(sampleBanks);
    console.log('Sample banks inserted');
    mongoose.connection.close();
  })
  .catch(err => console.log(err));
