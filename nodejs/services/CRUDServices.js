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

const deleteArticleFavouriteAfterDeleteArticle = async (req, res) => {
    const idBao = req.params.idBao;

    await connection.query('DELETE FROM YeuThichBaiBao WHERE idBao = ?', [idBao]);
    res.json({ success: true });
}
const updateArticle = async (req, res) => {
    const idBao = req.params.idBao;
    const { tieuDe, gioiThieu, noiDung, img_path, tacGia, danhMuc } = req.body;

    let [results, fields] = await connection.query('UPDATE BaiBao SET TieuDeBao = ?, GioiThieu = ?, NoiDung = ?, img_path = ?, idDanhMuc = ?, idTacGia = ? WHERE idBao = ?', [tieuDe, gioiThieu, noiDung, img_path, danhMuc, tacGia, idBao]);
    res.json({ message: 'Sửa bài báo thành công' });
}

const getListArticleFavourites = async (req, res) => {
    const idNguoiDung = req.user.idNguoiDung;

    let [results, fields] = await connection.query('SELECT * FROM YeuThichBaiBao INNER JOIN BaiBao ON YeuThichBaiBao.idBao = BaiBao.idBao INNER JOIN TacGia ON BaiBao.idTacGia = TacGia.idTacGia WHERE idNguoiDung = ?', [idNguoiDung]);
    res.json(results);
}

const getListArticleFind = async (req, res) => {
    try {
        const noiDung = req.body.noiDung;
        const [results, fields] = await connection.query(
            'SELECT * FROM BaiBao JOIN TacGia ON BaiBao.idTacGia = TacGia.idTacGia WHERE TieuDeBao LIKE ?',
            [`%${noiDung}%`]
        );
        res.json(results);
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Đã xảy ra lỗi.' });
    }
};

const updateTheView = async (req, res) => {
    const idBao = req.params.idBao;

    const [rows] = await connection.query('SELECT LuotXem FROM BaiBao WHERE idBao = ?', [idBao]);
    if (rows.length === 0) {
        return res.status(404).json({ message: 'Bài báo không tồn tại' });
    }

    const newCount = rows[0].LuotXem + 1;
    await connection.query('UPDATE BaiBao SET LuotXem = ? WHERE idBao = ?', [newCount, idBao]);

    res.json({ message: 'Tăng view bài báo thành công' });
};

const getArticleManyReads = async (req, res) => {
    let [results, fields] = await connection.query('SELECT * FROM BaiBao JOIN TacGia ON BaiBao.idTacGia = TacGia.idTacGia WHERE NgayDang >= DATE_SUB(NOW(), INTERVAL 3 DAY) ORDER BY LuotXem DESC LIMIT 5');
    res.json(results);
}

const getHotCategories = async (req, res) => {
    let [results, fields] = await connection.query('SELECT * FROM BaiBao JOIN TacGia ON BaiBao.idTacGia = TacGia.idTacGia WHERE idDanhMuc = 1');
    res.json(results);
}

const getNewCategories = async (req, res) => {
    let [results, fields] = await connection.query('SELECT * FROM BaiBao JOIN TacGia ON BaiBao.idTacGia = TacGia.idTacGia WHERE idDanhMuc = 2');
    res.json(results);
}

const getVietNamFootballCategories = async (req, res) => {
    let [results, fields] = await connection.query('SELECT * FROM BaiBao JOIN TacGia ON BaiBao.idTacGia = TacGia.idTacGia WHERE idDanhMuc = 3');
    res.json(results);
}

const getInternationalFootballCategories = async (req, res) => {
    let [results, fields] = await connection.query('SELECT * FROM BaiBao JOIN TacGia ON BaiBao.idTacGia = TacGia.idTacGia WHERE idDanhMuc = 4');
    res.json(results);
}

const getDocLaCategories = async (req, res) => {
    let [results, fields] = await connection.query('SELECT * FROM BaiBao JOIN TacGia ON BaiBao.idTacGia = TacGia.idTacGia WHERE idDanhMuc = 5');
    res.json(results);
}

const getLovedCategories = async (req, res) => {
    let [results, fields] = await connection.query('SELECT * FROM BaiBao JOIN TacGia ON BaiBao.idTacGia = TacGia.idTacGia WHERE idDanhMuc = 6');
    res.json(results);
}

const getEntertaimentCategories = async (req, res) => {
    let [results, fields] = await connection.query('SELECT * FROM BaiBao JOIN TacGia ON BaiBao.idTacGia = TacGia.idTacGia WHERE idDanhMuc = 7');
    res.json(results);
}

const getWorldCategories = async (req, res) => {
    let [results, fields] = await connection.query('SELECT * FROM BaiBao JOIN TacGia ON BaiBao.idTacGia = TacGia.idTacGia WHERE idDanhMuc = 8');
    res.json(results);
}

const getLawCategories = async (req, res) => {
    let [results, fields] = await connection.query('SELECT * FROM BaiBao JOIN TacGia ON BaiBao.idTacGia = TacGia.idTacGia WHERE idDanhMuc = 9');
    res.json(results);
}

const getDataVideoReels = async (req, res) => {
    let [results, fields] = await connection.query('SELECT Video.idVideo, Video.video_path, Video.TieuDe, TacGia.TenTacGia, TacGia.img_path_logo, COUNT(yt.idVideo) AS likes FROM Video JOIN TacGia ON Video.idTacGia = TacGia.idTacGia LEFT JOIN YeuThichVideo yt ON yt.idVideo = Video.idVideo GROUP BY Video.idVideo, Video.video_path, Video.TieuDe, TacGia.TenTacGia, TacGia.img_path_logo');
    res.json(results);
}

// API for check user have liked some article
const checkLikedVideo = async (req, res) => {
    const idNguoiDung = req.user.idNguoiDung;
    const idVideo = req.params.idVideo;

    let [results, fields] = await connection.query('SELECT * FROM YeuThichVideo WHERE idNguoiDung = ? AND idVideo = ?', [idNguoiDung, idVideo]);
    res.json(results);
}

// API for do liked some article
const addVideoFavourite = async (req, res) => {
    const idNguoiDung = req.user.idNguoiDung;
    const idVideo = req.params.idVideo;

    await connection.query('INSERT INTO YeuThichVideo VALUES (?, ?)', [idVideo, idNguoiDung]);
    res.json({ success: true });
}

// API for delete some favourite article
const deleteVideoFavourite = async (req, res) => {
    const idNguoiDung = req.user.idNguoiDung;
    const idVideo = req.params.idVideo;

    await connection.query('DELETE FROM YeuThichVideo WHERE idNguoiDung = ? AND idVideo = ?', [idNguoiDung, idVideo]);
    res.json({ success: true });
}

const createVideo = async (req, res) => {
    const { tieuDe, video_path, tacGia } = req.body;

    let [results, fields] = await connection.query('INSERT INTO Video(TieuDe, video_path, idTacGia) VALUES (?, ?, ?)', [tieuDe, video_path, tacGia]);
    res.json({ message: 'Tạo video thành công' });
}

const deleteVideo = async (req, res) => {
    const idVideo = req.params.idVideo;

    await connection.query('DELETE FROM Video WHERE idVideo = ?', [idVideo]);
    res.json({ success: true });
}

const deleteVideoFavouriteAfterDeleteVideo = async (req, res) => {
    const idVideo = req.params.idVideo;

    await connection.query('DELETE FROM YeuThichVideo WHERE idVideo = ?', [idVideo]);
    res.json({ success: true });
}

// API for get a news
const getVideoData = async (req, res) => {
    const idVideo = req.params.idVideo;
    let [results, fields] = await connection.query('SELECT * FROM Video WHERE idVideo = ?', [idVideo]);
    res.json(results);
}

const updateVideo = async (req, res) => {
    const idVideo = req.params.idVideo;
    const { TieuDe, video_path, idTacGia } = req.body;

    let [results, fields] = await connection.query('UPDATE Video SET TieuDe = ?, video_path = ?, idTacGia = ? WHERE idVideo = ?', [TieuDe, video_path, idTacGia, idVideo]);
    res.json({ message: 'Sửa bài báo thành công' });
}

const getListVideoFavourites = async (req, res) => {
    const idNguoiDung = req.user.idNguoiDung;

    let [results, fields] = await connection.query('SELECT * FROM YeuThichVideo INNER JOIN Video ON YeuThichVideo.idVideo = Video.idVideo INNER JOIN TacGia ON Video.idTacGia = TacGia.idTacGia WHERE idNguoiDung = ?', [idNguoiDung]);
    res.json(results);
}

module.exports = { getAllDatas, getNews, addArticleFavourite, login, checkLikedArticle, deleteArticleFavourite, getUserData, createAccount, checkExistAccount, createArtical, deleteArticle, updateArticle, getListArticleFavourites, getListArticleFind, deleteArticleFavouriteAfterDeleteArticle, updateTheView, getArticleManyReads, getDocLaCategories, getHotCategories, getNewCategories, getLawCategories, getWorldCategories, getEntertaimentCategories, getLovedCategories, getVietNamFootballCategories, getInternationalFootballCategories, getDataVideoReels, checkLikedVideo, deleteVideoFavourite, addVideoFavourite, createVideo, deleteVideo, deleteVideoFavouriteAfterDeleteVideo, getVideoData, updateVideo, getListVideoFavourites }
