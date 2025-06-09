import 'package:flutter/material.dart';
import 'package:flutter_project_group4/models/api.dart';

class EditVideo extends StatefulWidget {
  final int idVideo;
  const EditVideo({required this.idVideo, super.key});

  @override
  State<EditVideo> createState() => _EditVideo();
}

class _EditVideo extends State<EditVideo> {
  TextEditingController tieuDeVideoControllerEdit = TextEditingController();
  TextEditingController videoPathControllerEdit = TextEditingController();

  int? selectedAuthor = 1;
  DataService dataService = DataService();

  Widget radioAuthorListTitle() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cột 1
          Expanded(
            child: Column(
              children: [
                RadioListTile<int>(
                  title: Text('Nhân dân'),
                  value: 1,
                  groupValue: selectedAuthor,
                  onChanged: (value) {
                    setState(() {
                      selectedAuthor = value;
                    });
                  },
                ),
                RadioListTile<int>(
                  title: Text('Dân Trí'),
                  value: 2,
                  groupValue: selectedAuthor,
                  onChanged: (value) {
                    setState(() {
                      selectedAuthor = value;
                    });
                  },
                ),
              ],
            ),
          ),
          // Cột 2
          Expanded(
            child: Column(
              children: [
                RadioListTile<int>(
                  title: Text('Tuổi Trẻ'),
                  value: 3,
                  groupValue: selectedAuthor,
                  onChanged: (value) {
                    setState(() {
                      selectedAuthor = value;
                    });
                  },
                ),
                RadioListTile<int>(
                  title: Text('Thanh Niên'),
                  value: 4,
                  groupValue: selectedAuthor,
                  onChanged: (value) {
                    setState(() {
                      selectedAuthor = value;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Stack(
          children: [
            AppBar(
              title: Text(
                'Sửa video reels',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              automaticallyImplyLeading: true, // Hiện nút back
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Divider(
                height: 1,
                color: const Color.fromARGB(255, 166, 165, 165),
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: dataService.getDataSomeVideo(widget.idVideo),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Lỗi: ${snapshot.error}'));
          } else {
            final data = snapshot.data!;
            if (data.isEmpty) {
              return const Center(child: Text('Không tìm thấy video để sửa.'));
            }
            if (tieuDeVideoControllerEdit.text.isEmpty) {
              tieuDeVideoControllerEdit.text = data[0]['TieuDe'] ?? '';
              videoPathControllerEdit.text = data[0]['video_path'] ?? '';
              selectedAuthor = data[0]['idTacGia'] ?? 1;
            }
            return SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Tiêu đề video'),
                    SizedBox(height: 5),
                    TextField(
                      minLines: 1,
                      maxLines: null,
                      controller: tieuDeVideoControllerEdit,
                      decoration: InputDecoration(
                        hintText: data[0]['TieuDe'],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text('Link video'),
                    SizedBox(height: 5),
                    TextField(
                      minLines: 1,
                      maxLines: null,
                      controller: videoPathControllerEdit,
                      decoration: InputDecoration(
                        hintText: data[0]['video_path'],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text('Tác giả bài báo'),
                    radioAuthorListTitle(),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () async {
                          await dataService.editVideo(
                            tieuDeVideoControllerEdit.text,
                            videoPathControllerEdit.text,
                            selectedAuthor!,
                            widget.idVideo,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Sửa video thành công.')),
                          );
                          Navigator.of(
                            context,
                          ).popUntil((route) => route.isFirst);
                        },
                        child: Text(
                          'Sửa',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
