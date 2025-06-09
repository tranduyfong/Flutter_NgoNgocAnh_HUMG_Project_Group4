import 'package:flutter/material.dart';
import 'package:flutter_project_group4/models/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_tts/flutter_tts.dart';

class ReadingNews extends StatefulWidget {
  final int idBao;
  final String imgPathLogo;

  const ReadingNews({
    required this.idBao,
    required this.imgPathLogo,
    super.key,
  });

  @override
  State<ReadingNews> createState() => _ReadingNews();
}

class _ReadingNews extends State<ReadingNews> {
  FlutterTts flutterTts = FlutterTts();
  final DataService dataService = DataService();
  bool userIsLoggedIn = false;
  double fontSize = 24.0;
  bool isLiked = false;
  bool isSpeaking = false;
  double voiceVolume = 1.5;
  double voiceSpeed = 0.4;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
    _loadLikedStatus();
    _upViewArticle();

    flutterTts.setCompletionHandler(() {
      setState(() {
        isSpeaking = false;
      });
    });
  }

  // The function to check logged
  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    final token = prefs.getString('jwtToken');

    setState(() {
      userIsLoggedIn = isLoggedIn && token != null && token.isNotEmpty;
    });
  }

  Future<void> speak(String text) async {
    await flutterTts.setLanguage('vi-VN');
    await flutterTts.setSpeechRate(voiceSpeed);
    await flutterTts.setVolume(voiceVolume);

    setState(() {
      isSpeaking = true;
    });

    await flutterTts.speak(text);
  }

  Future<void> stopSpeaking() async {
    await flutterTts.stop();
    setState(() {
      isSpeaking = false;
    });
  }

  void _loadLikedStatus() async {
    bool liked = await dataService.checkLiked(widget.idBao);
    setState(() {
      isLiked = liked;
    });
  }

  void _likeArticle(int idBao) async {
    if (userIsLoggedIn) {
      bool currentLiked = await dataService.checkLiked(idBao);
      if (isLiked) {
        print('Huy like');
        DataService.deleteArticleFavourite(idBao);
      } else {
        print('Liked article: $idBao');
        DataService.addArticleFavourite(idBao);
      }
      setState(() {
        isLiked = !currentLiked;
      });
    } else {
      showDialogToRequestLikeArticle();
    }
  }

  void _upViewArticle() async {
    try {
      await dataService.upViewArticle(widget.idBao);
    } catch (e) {
      print('Lỗi cập nhật lượt xem: $e');
    }
  }

  void showDialogToRequestLikeArticle() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Bạn chưa đăng nhập'),
            content: Text('Hãy đăng nhập để yêu thích bài báo'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Hủy', style: TextStyle(color: Colors.red)),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: Text('Đăng nhập'),
              ),
            ],
          ),
    );
  }

  void showDialogToChangeSizeText() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Tùy chỉnh',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                  Divider(),
                  SizedBox(height: 10),
                  // Font size adjustment
                  Text('Cỡ chữ'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.text_decrease),
                        onPressed: () {
                          setModalState(
                            () => fontSize = (fontSize - 2).clamp(12.0, 50.0),
                          );
                          setState(() {});
                        },
                      ),
                      Text(fontSize.toStringAsFixed(0)),
                      IconButton(
                        icon: Icon(Icons.text_increase),
                        onPressed: () {
                          setModalState(
                            () => fontSize = (fontSize + 2).clamp(12.0, 50.0),
                          );
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  // Volume adjustment
                  Text('Âm lượng giọng đọc'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.volume_down),
                        onPressed: () {
                          setModalState(
                            () =>
                                voiceVolume = (voiceVolume - 0.2).clamp(
                                  0.0,
                                  1.0,
                                ),
                          );
                          setState(() {});
                        },
                      ),
                      Text(voiceVolume.toStringAsFixed(1)),
                      IconButton(
                        icon: Icon(Icons.volume_up),
                        onPressed: () {
                          setModalState(
                            () =>
                                voiceVolume = (voiceVolume + 0.2).clamp(
                                  0.0,
                                  1.0,
                                ),
                          );
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  // Speed adjustment
                  Text('Tốc độ giọng đọc'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_downward),
                        onPressed: () {
                          setModalState(
                            () =>
                                voiceSpeed = (voiceSpeed - 0.1).clamp(0.1, 1.0),
                          );
                          setState(() {});
                        },
                      ),
                      Text(voiceSpeed.toStringAsFixed(1)),
                      IconButton(
                        icon: Icon(Icons.arrow_upward),
                        onPressed: () {
                          setModalState(
                            () =>
                                voiceSpeed = (voiceSpeed + 0.1).clamp(0.1, 1.0),
                          );
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Đóng', style: TextStyle(color: Colors.grey)),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: SizedBox(
            width: 100,
            child: Image.network(
              widget.imgPathLogo,
              fit: BoxFit.contain,
              alignment: Alignment.center,
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            color: const Color.fromARGB(255, 221, 220, 220),
            height: 1.0,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => _likeArticle(widget.idBao),
            icon: Icon(
              Icons.favorite,
              color: isLiked ? Colors.pink : Colors.black,
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 15),
            child: IconButton(
              onPressed: () => showDialogToChangeSizeText(),
              icon: Icon(
                Icons.settings,
                color: const Color.fromARGB(255, 88, 87, 87),
              ),
            ),
          ),
        ],
        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
        scrolledUnderElevation: 0,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: dataService.getDataSomeNews(widget.idBao),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Lỗi: ${snapshot.error}'));
          } else {
            final data = snapshot.data!;
            int viewCount =
                data[0]['LuotXem'] is int
                    ? data[0]['LuotXem']
                    : int.parse(data[0]['LuotXem'].toString());
            return ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                  child: Column(
                    children: [
                      Text(
                        data[0]['TieuDeBao'],
                        style: TextStyle(
                          fontSize: fontSize + 2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Text(
                    '$viewCount lượt xem bài báo này',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.grey,
                      fontSize: fontSize - 10,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 30, 0, 0),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () async {
                          if (isSpeaking) {
                            await stopSpeaking();
                          } else {
                            await speak(
                              '${data[0]['TieuDeBao'] ?? ''}, ${data[0]['GioiThieu'] ?? ''}, ${data[0]['NoiDung'] ?? ''}',
                            );
                          }
                        },
                        icon: Icon(
                          isSpeaking
                              ? Icons.stop_circle
                              : Icons.volume_up_rounded,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Bấm vào đây để nghe bài báo',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.grey,
                          fontSize: fontSize - 10,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: Text(
                    data[0]['GioiThieu'],
                    style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Image.network(data[0]['img_path']),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Text(
                    data[0]['NoiDung'],
                    style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
