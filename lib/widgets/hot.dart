import 'package:flutter/material.dart';
import 'package:flutter_project_group4/screens/news.dart';
import 'package:flutter_project_group4/screens/reading.dart';
import 'package:flutter_project_group4/models/api.dart';
import 'package:cached_network_image/cached_network_image.dart'; // thêm thư viện này

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
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Lỗi: ${snapshot.error}'));
        } else {
          final data = snapshot.data!;
          return ListView.builder(
            itemCount: data.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                // Phần "ĐỌC NHIỀU"
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: SizedBox(
                    height: 300,
                    width: double.infinity,
                    child: Card(
                      margin: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 15, 0, 30),
                        child: Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'ĐỌC NHIỀU',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Expanded(
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  _buildDocNhieuItem(
                                    imgUrl:
                                        'https://image.nhandan.vn/Uploaded/2025/buimsbrobuyvco/2025_04_18/a1-dsc-4655-2540-908.jpg',
                                    title:
                                        'Tổng Bí thư Tô Lâm tiếp Tổng Giám đốc Quỹ đầu tư Warburg Pincus (Hoa Kỳ)',
                                  ),
                                  const SizedBox(width: 20),
                                  _buildDocNhieuItem(
                                    imgUrl:
                                        'https://file3.qdnd.vn/data/images/0/2025/04/19/upload_2268/thu%20truong%20quyet%202.jpg?dpi=150&quality=100&w=870',
                                    title:
                                        'Thượng tướng Trịnh Văn Quyết chủ trì tổng duyệt Chương trình nghệ thuật “Đất nước trọn niềm vui"',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                final item =
                    data[index - 1]; // trừ 1 vì index 0 là phần Đọc Nhiều
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: SizedBox(
                        height: 125,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder:
                                          (context) => ReadingNews(
                                            idBao: item['idBao']!,
                                            imgPathLogo: item['img_path_logo']!,
                                          ),
                                    ),
                                  );
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: CachedNetworkImage(
                                    imageUrl: item['img_path'],
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                    placeholder:
                                        (context, url) =>
                                            CircularProgressIndicator(),
                                    errorWidget:
                                        (context, url, error) =>
                                            Icon(Icons.error),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              flex: 7,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder:
                                              (context) => ReadingNews(
                                                idBao: item['idBao']!,
                                                imgPathLogo:
                                                    item['img_path_logo']!,
                                              ),
                                        ),
                                      );
                                    },
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      alignment: Alignment.topLeft,
                                    ),
                                    child: Text(
                                      item['TieuDeBao'],
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                        width: 40,
                                        child: CachedNetworkImage(
                                          imageUrl: item['img_path_logo']!,
                                          fit: BoxFit.contain,
                                          errorWidget:
                                              (context, url, error) =>
                                                  Icon(Icons.error),
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        NewsScreen.timeCreateAtTitle(
                                          item['NgayDang'],
                                        ),
                                        style: const TextStyle(fontSize: 12),
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
                    const Divider(height: 5),
                  ],
                );
              }
            },
          );
        }
      },
    );
  }

  Widget _buildDocNhieuItem({required String imgUrl, required String title}) {
    return SizedBox(
      width: 300,
      child: Column(
        children: [
          Expanded(
            flex: 4,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: imgUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            flex: 1,
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
