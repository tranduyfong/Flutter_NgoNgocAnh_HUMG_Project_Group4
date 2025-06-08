// video_item.dart
class VideoItem {
  final int idVideo;
  final String videoUrl;
  final String avatarUrl;
  final String name;
  final String description;
  final int likes;
  final bool isLiked;

  VideoItem({
    required this.idVideo,
    required this.videoUrl,
    required this.avatarUrl,
    required this.name,
    required this.description,
    required this.likes,
    this.isLiked = false,
  });

  VideoItem copyWith({int? likes, bool? isLiked}) {
    return VideoItem(
      idVideo: idVideo,
      videoUrl: videoUrl,
      avatarUrl: avatarUrl,
      name: name,
      description: description,
      likes: likes ?? this.likes,
      isLiked: isLiked ?? this.isLiked,
    );
  }
}
