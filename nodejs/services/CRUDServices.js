const connection = require('../config/database')
const { tokenLogin } = require('../middleware/jwtMiddleware');

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

// API for do liked some article
const addArticleFavourite = async (req, res) => {
    const idNguoiDung = req.user.idNguoiDung;
    const idBao = req.params.idBao;

    await connection.query('INSERT INTO YeuThichBaiBao VALUES (?, ?)', [idNguoiDung, idBao]);
    res.json({ success: true });
}

// API for delete some favourite article
const deleteArticleFavourite = async (req, res) => {
    const idNguoiDung = req.user.idNguoiDung;
    const idBao = req.params.idBao;

    await connection.query('DELETE FROM YeuThichBaiBao WHERE idNguoiDung = ? AND idBao = ?', [idNguoiDung, idBao]);
    res.json({ success: true });
}

// API for login
const login = async (req, res) => {
    const { email, password } = req.body;
    try {
        console.log("Login attempt:", email, password);

        const [users] = await connection.query(
            'SELECT * FROM NguoiDung WHERE Email = ? AND MatKhau = ?',
            [email, password]
        );
        if (users.length === 0) {
            return res.status(401).json({ message: 'Sai email hoặc mật khẩu' });
        }
        const user = users[0];
        console.log("Found user:", user);

        const token = tokenLogin({
            idNguoiDung: user.idNguoiDung,
            Email: user.email
        });
        res.json({ token });
    } catch (error) {
        console.error("Lỗi trong login:", error); // Log lỗi ra terminal
        return res.status(500).json({ message: 'Lỗi server', error: error.message });
    }
};

// API for check user have liked some article
const checkLikedArticle = async (req, res) => {
    const idNguoiDung = req.user.idNguoiDung;
    const idBao = req.params.idBao;

    let [results, fields] = await connection.query('SELECT * FROM YeuThichBaiBao WHERE idNguoiDung = ? AND idBao = ?', [idNguoiDung, idBao]);
    res.json(results);
}

// API for get User Data
const getUserData = async (req, res) => {
    const idNguoiDung = req.user.idNguoiDung;

    let [results, fields] = await connection.query('SELECT * FROM NguoiDung WHERE idNguoiDung = ?', [idNguoiDung]);
    res.json(results);
}

const createAccount = async (req, res) => {
    const { name, email, password } = req.body;

    let [results, fields] = await connection.query('INSERT INTO NguoiDung(TenNguoiDung, Email, MatKhau, PhanLoaiTaiKhoan) VALUES (?, ?, ?, ?)', [name, email, password, 0]);
    res.json({ message: 'Tạo tài khoản thành công' });
}

const checkExistAccount = async (req, res) => {
    const email = req.params.email;

    let [results, fields] = await connection.query('SELECT * FROM NguoiDung WHERE Email = ?', [email]);
    res.json(results);
}

const createArtical = async (req, res) => {
    const { tieuDe, gioiThieu, noiDung, img_path, tacGia, danhMuc } = req.body;
    const currentDate = new Date();

    let [results, fields] = await connection.query('INSERT INTO BaiBao(TieuDeBao, GioiThieu, NoiDung, img_path, NgayDang, idDanhMuc, idTacGia) VALUES (?, ?, ?, ?, ?, ?, ?)', [tieuDe, gioiThieu, noiDung, img_path, currentDate, danhMuc, tacGia]);
    res.json({ message: 'Tạo bài báo thành công' });
}
const deleteArticle = async (req, res) => {
    const idBao = req.params.idBao;

    await connection.query('DELETE FROM BaiBao WHERE idBao = ?', [idBao]);
    res.json({ success: true });
}

const updateArticle = async (req, res) => {
    const idBao = req.params.idBao;
    const { tieuDe, gioiThieu, noiDung, img_path, tacGia, danhMuc } = req.body;

    let [results, fields] = await connection.query('UPDATE BaiBao SET TieuDeBao = ?, GioiThieu = ?, NoiDung = ?, img_path = ?, idDanhMuc = ?, idTacGia = ? WHERE idBao = ?', [tieuDe, gioiThieu, noiDung, img_path, danhMuc, tacGia, idBao]);
    res.json({ message: 'Sửa bài báo thành công' });
}

module.exports = { getAllDatas, getNews, addArticleFavourite, login, checkLikedArticle, deleteArticleFavourite, getUserData, createAccount, checkExistAccount, createArtical, deleteArticle, updateArticle }
