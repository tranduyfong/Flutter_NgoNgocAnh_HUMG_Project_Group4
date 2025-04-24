require('dotenv').config();
const express = require('express');
const port = process.env.PORT || 8888;
const cors = require('cors');
const app = express();
const routes = require('./routes/web');

app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }))
app.use('/', routes);

app.listen(port, () => {
  console.log(`Server running on http://localhost:${port}`);
});