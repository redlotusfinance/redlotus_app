const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const mongoose = require('mongoose');

const app = express();
const PORT = process.env.PORT || 5000;
const HOST = '0.0.0.0'; // Listen on all network interfaces

// Middleware
app.use(cors());
app.use(bodyParser.json());

// --- Database Connection ---
const dbURI = 'mongodb://localhost:27017/fincare';
mongoose.connect(dbURI, { useNewUrlParser: true, useUnifiedTopology: true })
  .then(() => console.log('MongoDB connection established successfully'))
  .catch(err => console.error('MongoDB connection error:', err));

// --- API Routes ---
const submissionRoutes = require('./routes/submissionRoutes');
const adminRoutes = require('./routes/adminRoutes');
const bankRoutes = require('./routes/bankRoutes');
app.use('/api/user', submissionRoutes);
app.use('/api/admin', adminRoutes);
app.use('/api/banks', bankRoutes);


// --- Server Start ---
app.listen(PORT, HOST, () => {
  console.log(`Server is running on http://${HOST}:${PORT}`);
});
