import 'package:flutter/material.dart';
import 'package:flutter_project_group4/models/api.dart';
import 'package:flutter_project_group4/screens/news.dart';
import 'package:flutter_project_group4/screens/reading.dart';

class GiaitriWidget extends StatefulWidget {
  const GiaitriWidget({super.key});

  @override
  State<GiaitriWidget> createState() => _GiaitriWidget();
}

class _GiaitriWidget extends State<GiaitriWidget> {
  DataService dataService = DataService();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: FutureBuilder<List<dynamic>>(
        future: dataService.getEntertaimentCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Lỗi: ${snapshot.error}'));
          } else {
            final data = snapshot.data!;
            if (data.isEmpty) {
              return Center(child: Text('Chưa có bài báo danh mục này.'));
            }
            return ListView.builder(
              itemCount: data.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 150,
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
                                      Expanded(
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              height: 20,
                                              width: 40,
                                              child: Image.network(
                                                fit: BoxFit.contain,
                                                data[index]['img_path_logo']!,
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              NewsScreen.timeCreateAtTitle(
                                                data[index]['NgayDang'],
                                              ),
                                              style: const TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
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
            );
          }
        },
      ),
    );
  }
}
