// video_overlay.dart
import 'package:flutter/material.dart';

class VideoOverlay extends StatelessWidget {
  final int idVideo;
  final String avatarUrl;
  final String name;
  final String description;
  final int likes;
  final bool isLiked;
  final VoidCallback onLike;

  const VideoOverlay({
    super.key,
    required this.idVideo,
    required this.avatarUrl,
    required this.name,
    required this.description,
    required this.likes,
    required this.isLiked,
    required this.onLike,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 100,
      left: 16,
      right: 16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(avatarUrl),
                radius: 16,
              ),
              const SizedBox(width: 8),
              Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: onLike,
                child: Icon(
                  isLiked ? Icons.favorite : Icons.favorite_border,
                  color: isLiked ? Colors.red : Colors.white,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                likes.toString(),
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              description,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
