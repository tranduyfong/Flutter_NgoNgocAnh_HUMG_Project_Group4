import 'package:flutter/material.dart';
import 'package:flutter_project_group4/models/api.dart';
import 'package:flutter_project_group4/reels/reel_video.dart';
import 'package:flutter_project_group4/reels/video_item.dart';

class TrendingScreen extends StatefulWidget {
  const TrendingScreen({super.key});

  @override
  State<TrendingScreen> createState() => _TrendingScreenState();
}

class _TrendingScreenState extends State<TrendingScreen> {
  DataService dataService = DataService();
  late PageController _pageController;
  int _currentIndex = 0;
  List<VideoItem> videoItems = []; // Khởi tạo list videoItems rỗng
  bool _isLoading = true;

  @override
  void initState() {
    _pageController = PageController();
    _fetchData(); // Gọi hàm để fetch data từ API
    super.initState();
  }

  Future<void> _fetchData() async {
    try {
      final List<dynamic> data = await dataService.getDataVideoReels();
      final videos =
          data
              .map(
                (json) => VideoItem(
                  idVideo: json['idVideo'],
                  videoUrl: json['video_path'],
                  avatarUrl: json['img_path_logo'],
                  name: json['TenTacGia'],
                  description: json['TieuDe'],
                  likes: json['likes'],
                ),
              )
              .toList();
      setState(() {
        videoItems = videos;
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        controller: _pageController,
        itemCount: videoItems.length,
        onPageChanged: (index) {
          setState(() => _currentIndex = index);
        },
        itemBuilder: (context, index) {
          return ReelVideoPlayer(
            videoItem: videoItems[index],
            play: _currentIndex == index,
          );
        },
      ),
    );
  }
}
