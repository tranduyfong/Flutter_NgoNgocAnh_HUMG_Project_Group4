import 'package:flutter/material.dart';
import 'package:flutter_project_group4/models/api.dart';
import 'package:flutter_project_group4/screens/createvideo.dart';
import 'package:flutter_project_group4/screens/editvideo.dart';
import 'package:video_player/video_player.dart';

class ListVideoScreens extends StatefulWidget {
  const ListVideoScreens({super.key});

  @override
  State<ListVideoScreens> createState() => _ListVideoScreensState();
}

class _ListVideoScreensState extends State<ListVideoScreens> {
  final DataService dataService = DataService();

  void showDialogDeletedTitle(int idVideo) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Xóa video'),
            content: Text('Bạn thực sự có muốn xóa video này?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Hủy'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await dataService.deleteVideo(idVideo);
                  await dataService.deleteVideoFavouriteAfterDeleteVideo(
                    idVideo,
                  );
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                child: Text('Xóa', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
    );
  }

  Future<VideoPlayerController> _initializeVideoController(String url) async {
    final controller = VideoPlayerController.networkUrl(Uri.parse(url));
    await controller.initialize();
    return controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: Colors.blue,
        title: Center(
          child: Text('Danh sách video', style: TextStyle(color: Colors.white)),
        ),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: dataService.getDataVideoReels(), // Đảm bảo trả danh sách video
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Lỗi: ${snapshot.error}'));
          } else {
            final data = snapshot.data!;
            if (data.isEmpty) {
              return const Center(child: Text('Không có video nào.'));
            }
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final videoUrl = data[index]['video_path'];
                return FutureBuilder<VideoPlayerController>(
                  future: _initializeVideoController(videoUrl),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData) {
                      final controller = snapshot.data!;
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AspectRatio(
                              aspectRatio: controller.value.aspectRatio,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  VideoPlayer(controller),
                                  Icon(
                                    Icons.play_circle_fill,
                                    size: 60,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              data[index]['TieuDe'] ?? '',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Tác giả: ${data[index]['TenTacGia'] ?? 'Ẩn danh'}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder:
                                                (context) => EditVideo(
                                                  idVideo:
                                                      data[index]['idVideo'],
                                                ),
                                          ),
                                        );
                                        print(
                                          "Đang chuyển tới EditVideo với id: ${data[index]['idVideo']}",
                                        );
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {
                                        showDialogDeletedTitle(
                                          data[index]['idVideo'],
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Divider(),
                          ],
                        ),
                      );
                    } else {
                      return const Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => const CreateVideo()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
