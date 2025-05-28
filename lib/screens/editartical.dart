import 'package:flutter/material.dart';
import 'package:flutter_project_group4/models/api.dart';

class EditArtical extends StatefulWidget {
  final int idBao;

  const EditArtical({required this.idBao, super.key});

  @override
  State<EditArtical> createState() => _EditArtical();
}

class _EditArtical extends State<EditArtical> {
  TextEditingController tieuDeBaoControllerEdit = TextEditingController();
  TextEditingController gioiThieuControllerEdit = TextEditingController();
  TextEditingController noiDungControllerEdit = TextEditingController();
  TextEditingController imgPathControllerEdit = TextEditingController();
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
                'Chỉnh sửa bài báo',
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
        future: dataService.getDataSomeNews(widget.idBao),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Lỗi: ${snapshot.error}'));
          } else {
            final data = snapshot.data!;
            if (tieuDeBaoControllerEdit.text.isEmpty) {
              tieuDeBaoControllerEdit.text = data[0]['TieuDeBao'] ?? '';
              gioiThieuControllerEdit.text = data[0]['GioiThieu'] ?? '';
              noiDungControllerEdit.text = data[0]['NoiDung'] ?? '';
              imgPathControllerEdit.text = data[0]['img_path'] ?? '';
              selectedAuthor = data[0]['idTacGia'] ?? 1;
              selectedCategories = data[0]['idDanhMuc'] ?? 1;
            }
            return SafeArea(
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
                      controller: tieuDeBaoControllerEdit,
                      decoration: InputDecoration(
                        hintText: data[0]['TieuDeBao'],
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
                      controller: gioiThieuControllerEdit,
                      decoration: InputDecoration(
                        hintText: data[0]['GioiThieu'],
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
                      controller: imgPathControllerEdit,
                      decoration: InputDecoration(
                        hintText: data[0]['img_path'],
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
                      controller: noiDungControllerEdit,
                      decoration: InputDecoration(
                        hintText: data[0]['NoiDung'],
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
                          dataService.editArticle(
                            tieuDeBaoControllerEdit.text,
                            gioiThieuControllerEdit.text,
                            imgPathControllerEdit.text,
                            noiDungControllerEdit.text,
                            selectedAuthor!,
                            selectedCategories!,
                            widget.idBao,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Sửa bài báo thành công.')),
                          );
                          Navigator.of(
                            context,
                          ).popUntil((route) => route.isFirst);
                        },
                        child: Text(
                          'Sửa bài báo',
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
