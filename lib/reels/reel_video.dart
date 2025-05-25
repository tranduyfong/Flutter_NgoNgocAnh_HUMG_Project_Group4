// reel_video_player.dart (cập nhật hoàn chỉnh)

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'video_item.dart';
import 'video_overlay.dart';

class ReelVideoPlayer extends StatefulWidget {
  final VideoItem videoItem;
  final bool play;

  const ReelVideoPlayer({
    super.key,
    required this.videoItem,
    required this.play,
  });

  @override
  State<ReelVideoPlayer> createState() => _ReelVideoPlayerState();
}

class _ReelVideoPlayerState extends State<ReelVideoPlayer> {
  late VideoPlayerController _controller;
  late int _likes;
  bool _isLiked = false;

  @override
  void initState() {
    super.initState();

    _likes = widget.videoItem.likes;
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.videoItem.videoUrl),
    )
      ..initialize().then((_) {
        setState(() {});
        _controller.setLooping(true);
        _controller.setVolume(1.0);
        if (widget.play) _controller.play();
      });

    _controller.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void didUpdateWidget(covariant ReelVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.play != oldWidget.play) {
      widget.play ? _controller.play() : _controller.pause();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '$twoDigitMinutes:$twoDigitSeconds';
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return _controller.value.isInitialized
        ? SizedBox(
            height: size.height,
            width: size.width,
            child: Stack(
              children: [
                Center(
                  child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _controller.value.isPlaying
                              ? _controller.pause()
                              : _controller.play();
                        });
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          VideoPlayer(_controller),
                          if (!_controller.value.isPlaying)
                            Icon(
                              Icons.play_circle_fill,
                              color: Colors.white,
                              size: 100,
                              shadows: [
                                Shadow(
                                  color: Colors.black,
                                  offset: Offset(0, 0),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                VideoOverlay(
                  avatarUrl: widget.videoItem.avatarUrl,
                  name: widget.videoItem.name,
                  description: widget.videoItem.description,
                  likes: _likes,
                  isLiked: _isLiked,
                  onLike: () {
                    setState(() {
                      _isLiked = !_isLiked;
                      _likes += _isLiked ? 1 : -1;
                    });
                  },
                ),
                Positioned(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      VideoProgressIndicator(
                        _controller,
                        allowScrubbing: true,
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        colors: VideoProgressColors(
                          backgroundColor: Colors.white,
                          playedColor: Colors.red,
                          bufferedColor: Colors.grey,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _formatDuration(_controller.value.position),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            _formatDuration(_controller.value.duration),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        : const Center(child: CircularProgressIndicator());
  }
}
