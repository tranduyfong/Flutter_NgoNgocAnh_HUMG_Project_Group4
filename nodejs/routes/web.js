const express = require('express');
const { authMiddleWare } = require('../middleware/jwtMiddleware')
const router = express.Router();
const { getAllDatas, getNews, addArticleFavourite, login, checkLikedArticle, deleteArticleFavourite } = require('../services/CRUDServices');

router.get('/', getAllDatas);
router.get('/getNews/:idBao', getNews);
router.post('/favourite/:idBao/like', authMiddleWare, addArticleFavourite);
router.post('/login', login);
router.get('/checkLikedArticle/:idBao', authMiddleWare, checkLikedArticle);
router.delete('/favourite/:idBao/delete', authMiddleWare, deleteArticleFavourite)
module.exports = router;