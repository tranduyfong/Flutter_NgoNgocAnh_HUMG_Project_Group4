const express = require('express');
const mysql = require('mysql2');
require('dotenv').config();
const port = process.env.PORT || 8888;
const cors = require('cors');


const app = express();
app.use(cors());
app.use(express.json());

// Cấu hình kết nối
const connection = mysql.createPool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  port: process.env.DB_PORT,
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0
});

// API để lấy dữ liệu
app.get('/api/data', (req, res) => {
  connection.query('SELECT * FROM news', (err, results) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json(results);
  });
});

app.listen(port, () => {
  console.log(`Server running on http://localhost:${port}`);
});