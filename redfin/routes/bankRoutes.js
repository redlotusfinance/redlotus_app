const express = require('express');
const router = express.Router();
const { getMatchedBanks } = require('../controllers/bankController');

// Changed to POST to accept complex body data (existing loans list)
router.post('/match', getMatchedBanks);

module.exports = router;
