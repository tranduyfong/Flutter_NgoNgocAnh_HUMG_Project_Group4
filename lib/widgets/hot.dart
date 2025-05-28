import 'package:flutter/material.dart';
import 'package:flutter_project_group4/screens/news.dart';
import 'package:flutter_project_group4/screens/reading.dart';
import 'package:flutter_project_group4/models/api.dart';

class HotWidget extends StatefulWidget {
  const HotWidget({super.key});

  @override
  State<HotWidget> createState() => _HotWidgetState();
}

class _HotWidgetState extends State<HotWidget> {
  final DataService dataService = DataService();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: dataService.getAllData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Lỗi: ${snapshot.error}'));
        } else {
          final data = snapshot.data!;
          return ListView(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 300,
                    width: double.infinity,
                    child: Card(
                      margin: const EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 15, 0, 30),
                        child: Column(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'ĐỌC NHIỀU',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Expanded(
                              flex: 10,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: <Widget>[
                                  SizedBox(
                                    width: 300,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          flex: 4,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            child: GestureDetector(
                                              onTap: () {
                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      'Đăng nhập thất bại',
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Image.network(
                                                fit: BoxFit.cover,
                                                'https://image.nhandan.vn/Uploaded/2025/buimsbrobuyvco/2025_04_18/a1-dsc-4655-2540-908.jpg',
                                                width: double.infinity,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            'Tổng Bí thư Tô Lâm tiếp Tổng Giám đốc Quỹ đầu tư Warburg Pincus (Hoa Kỳ)',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  SizedBox(
                                    width: 300,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          flex: 4,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            child: Image.network(
                                              fit: BoxFit.cover,
                                              'https://file3.qdnd.vn/data/images/0/2025/04/19/upload_2268/thu%20truong%20quyet%202.jpg?dpi=150&quality=100&w=870',
                                              width: double.infinity,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            'Thượng tướng Trịnh Văn Quyết chủ trì tổng duyệt Chương trình nghệ thuật “Đất nước trọn niềm vui',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              ListView.builder(
                itemCount: data.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 125,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder:
                                              (context) => ReadingNews(
                                                idBao: data[index]['idBao']!,
                                                imgPathLogo:
                                                    data[index]['img_path_logo']!,
                                              ),
                                        ),
                                      );
                                    },
                                    child: Image.network(
                                      fit: BoxFit.cover,
                                      height: double.infinity,
                                      data[index]['img_path'],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                flex: 7,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder:
                                                (context) => ReadingNews(
                                                  idBao: data[index]['idBao']!,
                                                  imgPathLogo:
                                                      data[index]['img_path_logo']!,
                                                ),
                                          ),
                                        );
                                      },
                                      style: ButtonStyle(
                                        padding: WidgetStateProperty.all(
                                          EdgeInsets.zero,
                                        ),
                                      ),
                                      child: Align(
                                        // alignment: Alignment.topLeft,
                                        child: Text(
                                          data[index]['TieuDeBao'],
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 17,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          height: 20,
                                          width: 40,
                                          child: Image.network(
                                            fit: BoxFit.contain,
                                            data[index]['img_path_logo']!,
                                          ),
                                        ),
                                        Text(
                                          NewsScreen.timeCreateAtTitle(
                                            data[index]['NgayDang'],
                                          ),
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(height: 5),
                    ],
                  );
                },
              ),
            ],
          );
        }
      },
    );
  }
}
