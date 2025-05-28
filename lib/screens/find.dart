import 'package:flutter/material.dart';
import 'package:flutter_project_group4/models/api.dart';
import 'package:flutter_project_group4/screens/reading.dart';

class FindingScreen extends StatefulWidget {
  const FindingScreen({super.key});

  @override
  State<FindingScreen> createState() => _FindingScreenState();
}

class _FindingScreenState extends State<FindingScreen> {
  final TextEditingController textEditingController = TextEditingController();
  DataService dataService = DataService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: Colors.blue,
        title: Row(
          children: [
            Expanded(
              flex: 9,
              child: TextField(
                onSubmitted: (value) {
                  setState(() {});
                },
                controller: textEditingController,
                decoration: InputDecoration(
                  hintText: 'Tìm kiếm...',
                  border: InputBorder.none,
                ),
                textInputAction: TextInputAction.done,
              ),
            ),
            Expanded(
              flex: 1,
              child: TextButton(
                onPressed: () => textEditingController.clear(),
                child: Icon(Icons.close),
              ),
            ),
          ],
        ),
      ),
      body:
          textEditingController.text.isEmpty
              ? Center(child: Text('Chưa có thông tin nhập vào'))
              : FutureBuilder<List<dynamic>>(
                future: dataService.findArticle(textEditingController.text),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Lỗi: ${snapshot.error}'));
                  } else {
                    final data = snapshot.data!;
                    if (data.isEmpty) {
                      return Center(
                        child: Text(
                          'Không có kết quả phù hợp với "${textEditingController.text}"',
                        ),
                      );
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
                                                      idBao:
                                                          data[index]['idBao']!,
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
                                                        idBao:
                                                            data[index]['idBao']!,
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
