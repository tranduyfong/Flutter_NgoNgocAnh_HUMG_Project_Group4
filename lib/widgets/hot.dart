import 'package:flutter/material.dart';
import 'package:flutter_project_group4/screens/news.dart';
import 'package:flutter_project_group4/screens/reading.dart';
import 'package:flutter_project_group4/models/api.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HotWidget extends StatefulWidget {
  const HotWidget({super.key});

  @override
  State<HotWidget> createState() => _HotWidgetState();
}

class _HotWidgetState extends State<HotWidget> {
  final DataService dataService = DataService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<List<dynamic>>>(
      future: Future.wait([
        dataService.getHotCategories(),
        dataService.getArticleManyReads(),
      ]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Lỗi: ${snapshot.error}'));
        } else {
          final alldData = snapshot.data![0];
          final manyReadArticles = snapshot.data![1];
          return ListView.builder(
            itemCount: alldData.length + 1,
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
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: manyReadArticles.length,
                                separatorBuilder:
                                    (_, __) => const SizedBox(width: 20),
                                itemBuilder: (context, i) {
                                  final news = manyReadArticles[i];
                                  return _buildDocNhieuItem(
                                    imgUrl: news['img_path'],
                                    title: news['TieuDeBao'],
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder:
                                              (context) => ReadingNews(
                                                idBao: news['idBao'],
                                                imgPathLogo:
                                                    news['img_path_logo'],
                                              ),
                                        ),
                                      );
                                    },
                                  );
                                },
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
                    alldData[index - 1]; // trừ 1 vì index 0 là phần Đọc Nhiều
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

  Widget _buildDocNhieuItem({
    required String imgUrl,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
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
      ),
    );
  }
}
