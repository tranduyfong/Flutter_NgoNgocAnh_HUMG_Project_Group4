import 'package:flutter/material.dart';
import 'package:flutter_project_group4/screens/find.dart';
import 'package:flutter_project_group4/screens/reading.dart';

class HotWidget extends StatefulWidget {
  const HotWidget({super.key});

  @override
  State<HotWidget> createState() => _HotWidgetState();
}

class _HotWidgetState extends State<HotWidget> {
  @override
  Widget build(BuildContext context) {
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
                                      borderRadius: BorderRadius.circular(10),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder:
                                                  (context) => ReadingNews(),
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
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        fit: BoxFit.cover,
                                        'https://static-images.vnncdn.net/vps_images_publish/000001/000003/2025/4/20/batch-01-sv-2226.jpg?width=0&s=YNICSh7Jj6_xzaUHS6-FJw',
                                        width: double.infinity,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      'Diễn viên Thiên Tàn qua đời đột ngột đúng ngày sinh nhật, hưởng dương 30 tuổi',
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
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        fit: BoxFit.cover,
                                        'https://file3.qdnd.vn/data/images/0/2025/04/20/upload_2268/3.jpg?dpi=150&quality=100&w=870',
                                        width: double.infinity,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      'Pháo hoa rực sáng trên bầu trời TP Hồ Chí Minh',
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
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        fit: BoxFit.cover,
                                        'https://cdnmedia.baotintuc.vn/Upload/ESSoZh9IeVhxwO8Bh87Q/files/2025/04/19/iran19425.jpg',
                                        width: double.infinity,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      'Mỹ không ủng hộ, Israel vẫn cân nhắc kế hoạch tấn công các cơ sở hạt nhân của Iran',
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
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        fit: BoxFit.cover,
                                        'https://cdnmedia.baotintuc.vn/Upload/G5r0l6AdtRt8AnPUeQGMA/files/2025/04/1604/1604-trump1.jpg',
                                        width: double.infinity,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      'Mỹ tăng thuế 245% lên hàng Trung Quốc: Căng thẳng thương mại Mỹ - Trung bùng nổ',
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
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        fit: BoxFit.cover,
                                        'https://cdnmedia.baotintuc.vn/Upload/OND64xLJqhpDJlQ2Gd1dpw/files/2025/04/tap-can-binh-14425d.jpg',
                                        width: double.infinity,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      'Tổng Bí thư, Chủ tịch nước Trung Quốc Tập Cận Bình đến Hà Nội, bắt đầu chuyến thăm cấp Nhà nước tới Việt Nam',
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
                                      borderRadius: BorderRadius.circular(10),
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
          itemCount: 10,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Column(
              children: [
                SizedBox(
                  height: 100,
                  child: Center(
                    child: Text(
                      'Title $index',
                      style: TextTheme.of(context).headlineSmall,
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
}
