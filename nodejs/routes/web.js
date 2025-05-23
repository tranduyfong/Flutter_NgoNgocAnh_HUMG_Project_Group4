const express = require('express');
const { authMiddleWare } = require('../middleware/jwtMiddleware')
const router = express.Router();
const { getAllDatas, getNews, addArticleFavourite, login, checkLikedArticle, deleteArticleFavourite, getUserData, createAccount, checkExistAccount, createArtical, deleteArticle, updateArticle, getListArticleFavourites, getListArticleFind, deleteArticleFavouriteAfterDeleteArticle, updateTheView } = require('../services/CRUDServices');

router.get('/', getAllDatas);
router.get('/getNews/:idBao', getNews);
router.post('/favourite/:idBao/like', authMiddleWare, addArticleFavourite);
router.post('/login', login);
router.get('/checkLikedArticle/:idBao', authMiddleWare, checkLikedArticle);
router.delete('/favourite/:idBao/delete', authMiddleWare, deleteArticleFavourite);
router.get('/user/data', authMiddleWare, getUserData);
router.post('/create/user', createAccount);
router.get('/checkExistAccount/:email', checkExistAccount);
router.post('/create/article', createArtical);
router.delete('/delete/article/:idBao', deleteArticle);
router.delete('/delete/articleFavourite/:idBao', deleteArticleFavouriteAfterDeleteArticle);
router.put('/update/article/:idBao', updateArticle);
router.get('/get/list/favourites', authMiddleWare, getListArticleFavourites);
router.post('/get/list/find', getListArticleFind);
router.put('/update/view/:idBao', updateTheView)
module.exports = router;