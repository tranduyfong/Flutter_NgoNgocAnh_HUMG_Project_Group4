import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class TrendingScreen extends StatefulWidget {
  const TrendingScreen({super.key});

  @override
  State<TrendingScreen> createState() => _TrendingScreen();
}

class _TrendingScreen extends State<TrendingScreen> {
  late VideoPlayerController _videoPlayerController;
  PageController pageController = PageController();
  late Uri pathUrl;

  Widget _buildProgressBar() {
    final position = _videoPlayerController.value.position;
    final duration = _videoPlayerController.value.duration;

    final progress =
        duration.inMilliseconds > 0
            ? position.inMilliseconds / duration.inMilliseconds
            : 0.0;

    return LinearProgressIndicator(
      value: progress,
      valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
      backgroundColor: const Color.fromARGB(255, 75, 73, 73),
      minHeight: 1,
    );
  }

  @override
  void initState() {
    super.initState();
    _videoPlayerController =
        VideoPlayerController.networkUrl(
            Uri.parse(
              'https://streaming-cms-tpo.epicdn.me/aae964e2df4fd050df7ea4f2cdbf35b1/681845d0/2025_05_04/c0049_4760.mp4',
            ),
          )
          ..addListener(() {
            if (mounted) {
              setState(() {});
            }
          })
          ..setLooping(true)
          ..initialize().then((_) {
            setState(() {}); // Khi video đã sẵn sàng
            _videoPlayerController.play(); // Tự động phát
          });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: 3,
      scrollDirection: Axis.vertical,
      controller: pageController,
      onPageChanged: (value) {
        setState(() {
          _videoPlayerController.play();
          _videoPlayerController.seekTo(Duration.zero);
        });
      },
      itemBuilder: (context, index) {
        return Container(
          color: Colors.black,
          child: Column(
            children: [
              Expanded(
                flex: 6,
                child:
                    _videoPlayerController.value.isInitialized
                        ? GestureDetector(
                          onTap: () {
                            setState(() {
                              _videoPlayerController.value.isPlaying
                                  ? _videoPlayerController.pause()
                                  : _videoPlayerController.play();
                            });
                          },
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: SizedBox(
                              width: _videoPlayerController.value.size.width,
                              height: _videoPlayerController.value.size.height,
                              child: AspectRatio(
                                aspectRatio:
                                    _videoPlayerController.value.aspectRatio,
                                child: VideoPlayer(_videoPlayerController),
                              ),
                            ),
                          ),
                        )
                        : Container(),
              ),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: Image.network(
                                      'https://yt3.googleusercontent.com/wVJk5uLYiKqPT5_Ucz5gxGJxMVdIHG1TDz5HXrlRR_JSRpMyhxOvQJzqy91XidLXH0Z6cfZyfMQ=s900-c-k-c0x00ffffff-no-rj',
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'Tien Phong',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'Người dân trở lại Thủ đô sau lễ, cửa ngõ phía Nam ùn ứ, nội đô thông thoáng',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ),
                    ),
                    _buildProgressBar(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
