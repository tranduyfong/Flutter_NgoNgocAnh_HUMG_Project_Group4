const express = require('express');
const router = express.Router();
const { getAllDatas, getNews } = require('../services/CRUDServices');

router.get('/', getAllDatas);
router.get('/getNews/:idBao', getNews);

module.exports = router;