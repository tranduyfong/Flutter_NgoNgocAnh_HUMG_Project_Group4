const connection = require('../config/database')

// API for get all datas
const getAllDatas = async (req, res) => {
    let [results, fields] = await connection.query('SELECT * FROM BaiBao JOIN TacGia ON BaiBao.idTacGia = TacGia.idTacGia');
    res.json(results);
}

// API for get a news
const getNews = async (req, res) => {
    const idBao = req.params.idBao;
    let [results, fields] = await connection.query('SELECT * FROM BaiBao WHERE idBao = ?', [idBao]);
    res.json(results);
}

const addNewArticleFavourite = async (req, res) => {
    const idNguoiDung = req.user.idNguoiDung;
    const idBao = req.params.idBao;

    await connection.query('INSERT INTO YeuThichBaiBao VALUES (?, ?)', [idNguoiDung, idBao]);
    res.json({ success: true });
}

module.exports = { getAllDatas, getNews, addNewArticleFavourite }