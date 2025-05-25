import 'package:flutter/material.dart';
import 'package:flutter_project_group4/reels/reel_video.dart';
import 'package:flutter_project_group4/reels/video_item.dart';

class TrendingScreen extends StatefulWidget {
  const TrendingScreen({super.key});

  @override
  State<TrendingScreen> createState() => _TrendingScreenState();
}

class _TrendingScreenState extends State<TrendingScreen> {
  late PageController _pageController;
  int _currentIndex = 0;

  final List<VideoItem> videoItems = [
    VideoItem(
      videoUrl:
          'https://streaming-cms-tpo.epicdn.me/b3c194cb296e2ab7a36583c1a08d5a46/6831fb10/2025_05_23/giang_thanh_01_1732.mp4',
      avatarUrl: 'https://cdn-icons-png.flaticon.com/512/25/25231.png',
      name: 'NHỊP SỐNG 24',
      description:
          'Chuyên gia nói gì về việc nhiều người trẻ chọn trút nỗi lòng với AI?',
      likes: 200,
      isLiked: false,
    ),
    VideoItem(
      videoUrl:
          'https://streaming-cms-tpo.epicdn.me/b944e5526c6290ef008ff56bd416aaa1/6831fb10/2025_05_23/viettel_9317.mp4',
      avatarUrl: 'https://cdn-icons-png.flaticon.com/512/847/847969.png',
      name: 'TIN NHANH',
      description:
          'Lòng xe điếu hiếm, nếu bị "phù phép" sẽ nguy hiểm như thế nào?',
      likes: 850,
      isLiked: false,
    ),
  ];

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
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
