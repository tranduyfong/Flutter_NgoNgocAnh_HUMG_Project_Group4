const express = require('express');
const { authMiddleWare } = require('../middleware/jwtMiddleware')
const router = express.Router();
const { getAllDatas, getNews, addArticleFavourite, login, checkLikedArticle, deleteArticleFavourite, getUserData, createAccount, checkExistAccount } = require('../services/CRUDServices');

router.get('/', getAllDatas);
router.get('/getNews/:idBao', getNews);
router.post('/favourite/:idBao/like', authMiddleWare, addArticleFavourite);
router.post('/login', login);
router.get('/checkLikedArticle/:idBao', authMiddleWare, checkLikedArticle);
router.delete('/favourite/:idBao/delete', authMiddleWare, deleteArticleFavourite);
router.get('/user/data', authMiddleWare, getUserData);
router.post('/create/user', createAccount);
router.get('/checkExistAccount/:email', checkExistAccount);
module.exports = router;