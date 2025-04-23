require('dotenv').config();
const express = require('express');
const port = process.env.PORT || 8888;
const cors = require('cors');
const app = express();
const connection = require('./config/database')
app.use(cors());
app.use(express.json());



// API for get all datas
app.get('/', (req, res) => {
  connection.query('SELECT * FROM BaiBao JOIN TacGia ON BaiBao.idTacGia = TacGia.idTacGia', (err, results) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json(results)
  });
});

// API for get all datas
app.get('/getNews', (req, res) => {
  const newsId = req.query.idBao;
  connection.query('SELECT * FROM BaiBao WHERE idBao = ?', [newsId], (err, results) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json(results)
  });

});
app.listen(port, () => {
  console.log(`Server running on http://localhost:${port}`);
});