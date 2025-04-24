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

module.exports = { getAllDatas, getNews }