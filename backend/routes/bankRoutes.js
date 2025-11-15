const express = require('express');
const router = express.Router();
const { getMatchedBanks } = require('../controllers/bankController');

router.get('/match', getMatchedBanks);

module.exports = router;
