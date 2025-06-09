const express = require('express');
const { authMiddleWare } = require('../middleware/jwtMiddleware')
const router = express.Router();
const { getAllDatas, getNews, addArticleFavourite, login, checkLikedArticle, deleteArticleFavourite, getUserData, createAccount, checkExistAccount, createArtical, deleteArticle, updateArticle, getListArticleFavourites, getListArticleFind, deleteArticleFavouriteAfterDeleteArticle, updateTheView, getArticleManyReads, getHotCategories, getVietNamFootballCategories, getNewCategories, getInternationalFootballCategories, getDocLaCategories, getLovedCategories, getEntertaimentCategories, getWorldCategories, getLawCategories, getDataVideoReels, checkLikedVideo, addVideoFavourite, deleteVideoFavourite, createVideo, deleteVideo, deleteVideoFavouriteAfterDeleteVideo, getVideoData, updateVideo, getListVideoFavourites } = require('../services/CRUDServices');

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
router.put('/update/view/:idBao', updateTheView);
router.get('/get/articleManyReads', getArticleManyReads);

router.get('/get/hot', getHotCategories);
router.get('/get/new', getNewCategories);
router.get('/get/vietnamfootball', getVietNamFootballCategories);
router.get('/get/international', getInternationalFootballCategories);
router.get('/get/docvala', getDocLaCategories);
router.get('/get/loved', getLovedCategories);
router.get('/get/entertaiment', getEntertaimentCategories);
router.get('/get/world', getWorldCategories);
router.get('/get/law', getLawCategories);

router.get('/get/video', getDataVideoReels);
router.get('/checkLikedVideo/:idVideo', authMiddleWare, checkLikedVideo);
router.post('/video/favourite/:idVideo/like', authMiddleWare, addVideoFavourite);
router.delete('/video/favourite/:idVideo/delete', authMiddleWare, deleteVideoFavourite);
router.post('/create/video', createVideo);
router.delete('/delete/video/:idVideo', deleteVideo);
router.delete('/delete/videoFavourite/:idVideo', deleteVideoFavouriteAfterDeleteVideo);
router.get('/getVideo/:idVideo', getVideoData);
router.put('/update/video/:idVideo', updateVideo);
router.get('/get/list/favourites/video', authMiddleWare, getListVideoFavourites);
module.exports = router;