const express = require('express');
const { authMiddleWare } = require('../middleware/jwtMiddleware')
const router = express.Router();
const { getAllDatas, getNews, addNewArticleFavourite, login } = require('../services/CRUDServices');

router.get('/', getAllDatas);
router.get('/getNews/:idBao', getNews);
router.post('/favourite/:idBao/like', authMiddleWare, addNewArticleFavourite);
router.post('/login', login)
module.exports = router;