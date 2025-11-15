const express = require('express');
const router = express.Router();
const { addBank } = require('../controllers/adminController');

router.post('/banks', addBank);

module.exports = router;
