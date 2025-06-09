import 'package:flutter/material.dart';
import 'package:flutter_project_group4/models/api.dart';

class CreateVideo extends StatefulWidget {
  const CreateVideo({super.key});

  @override
  State<CreateVideo> createState() => _CreateVideo();
}

class _CreateVideo extends State<CreateVideo> {
  TextEditingController tieuDeVideoController = TextEditingController();
  TextEditingController videoPathController = TextEditingController();

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
                'Tạo video reels',
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
      body: SafeArea(
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
                controller: tieuDeVideoController,
                decoration: InputDecoration(
                  hintText: 'Nhập tiêu đề video',
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
                controller: videoPathController,
                decoration: InputDecoration(
                  hintText: 'Nhập link video',
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
                    await dataService.addNewVideo(
                      tieuDeVideoController.text,
                      videoPathController.text,
                      selectedAuthor!,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Tạo video thành công.')),
                    );
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  child: Text(
                    'Thêm',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
