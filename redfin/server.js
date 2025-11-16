const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const mongoose = require('mongoose');

const app = express();
const PORT = process.env.PORT || 8080; // Firebase App Hosting uses port 8080
const HOST = '0.0.0.0'; 

// Middleware
app.use(cors());
app.use(bodyParser.json());

// --- Database Connection ---
const dbURI = 'mongodb+srv://redlotusconsultants_db_user:YpsUuMRrzTiz13jU@redlotus.5zlo9jt.mongodb.net/?appName=RedLotus'; 

mongoose.connect(dbURI)
  .then(() => console.log('MongoDB Atlas connection established successfully'))
  .catch(err => console.error('MongoDB Atlas connection error:', err));

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
