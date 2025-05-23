import 'package:flutter/material.dart';
import 'package:flutter_project_group4/models/api.dart';

class CreateTitle extends StatefulWidget {
  const CreateTitle({super.key});

  @override
  State<CreateTitle> createState() => _CreateTitleState();
}

class _CreateTitleState extends State<CreateTitle> {
  TextEditingController tieuDeBaoController = TextEditingController();
  TextEditingController gioiThieuController = TextEditingController();
  TextEditingController noiDungController = TextEditingController();
  TextEditingController imgPathController = TextEditingController();
  DataService dataService = DataService();

  int? selectedAuthor = 1;
  int? selectedCategories = 1;
  final List<String> categories = [
    'Nóng',
    'Mới',
    'Bóng đá VN',
    'Bóng đá QT',
    'Độc & Lạ',
    'Tình Yêu',
    'Giải trí',
    'Thế giới',
    'Pháp luật',
  ];

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

  Widget radioCategoriesListTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children:
            categories.map((category) {
              return RadioListTile<int>(
                title: Text(category),
                value: categories.indexOf(category) + 1,
                groupValue: selectedCategories,
                onChanged: (value) {
                  setState(() {
                    selectedCategories = value;
                  });
                },
              );
            }).toList(),
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
                'Tạo bài báo',
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
              Text('Tiêu đề bài báo'),
              SizedBox(height: 5),
              TextField(
                minLines: 1,
                maxLines: null,
                controller: tieuDeBaoController,
                decoration: InputDecoration(
                  hintText: 'Nhập tiêu đề bài báo',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text('Giới thiệu bài báo'),
              SizedBox(height: 5),
              TextField(
                minLines: 1,
                maxLines: null,
                controller: gioiThieuController,
                decoration: InputDecoration(
                  hintText: 'Nhập giới thiệu bài báo',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text('Link ảnh bài báo'),
              SizedBox(height: 5),
              TextField(
                minLines: 1,
                maxLines: null,
                controller: imgPathController,
                decoration: InputDecoration(
                  hintText: 'Nhập link ảnh bài báo',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text('Nội dung bài báo'),
              SizedBox(height: 5),
              TextField(
                minLines: 5,
                maxLines: null,
                controller: noiDungController,
                decoration: InputDecoration(
                  hintText: 'Nhập nội dung bài báo',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text('Tác giả bài báo'),
              radioAuthorListTitle(),
              SizedBox(height: 20),
              Text('Danh mục bài báo'),
              radioCategoriesListTitle(),
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
                    dataService.addNewArticle(
                      tieuDeBaoController.text,
                      gioiThieuController.text,
                      imgPathController.text,
                      noiDungController.text,
                      selectedAuthor!,
                      selectedCategories!,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Tạo bài báo thành công.')),
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
