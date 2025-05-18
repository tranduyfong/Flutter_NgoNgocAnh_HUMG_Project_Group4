import 'package:flutter/material.dart';
import 'package:flutter_project_group4/models/api.dart';
import 'package:flutter_project_group4/screens/createtitle.dart';
import 'package:flutter_project_group4/screens/news.dart';
import 'package:flutter_project_group4/screens/reading.dart';

class ListTitleScreens extends StatefulWidget {
  const ListTitleScreens({super.key});

  @override
  State<ListTitleScreens> createState() => _ListTitleScreens();
}

class _ListTitleScreens extends State<ListTitleScreens> {
  final TextEditingController textEditingController = TextEditingController();
  final DataService dataService = DataService();

  void showDialogDeletedTitle(int idBao) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Xóa bài báo'),
            content: Text('Bạn thực sự có muốn xóa bài báo này ?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Hủy'),
              ),
              ElevatedButton(
                onPressed: () {
                  dataService.deleteArticle(idBao);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => ListTitleScreens()),
                    (Route<dynamic> route) =>
                        false, // Xóa tất cả các route trước đó
                  );
                },
                child: Text('Xóa', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
    );
  }

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
      body: FutureBuilder<List<dynamic>>(
        future: dataService.getAllData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Lỗi: ${snapshot.error}'));
          } else {
            final data = snapshot.data!;
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
                                            Text(
                                              NewsScreen.timeCreateAtTitle(
                                                data[index]['NgayDang'],
                                              ),
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: [
                                            IconButton(
                                              onPressed: () {},
                                              icon: Icon(Icons.edit),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                showDialogDeletedTitle(
                                                  data[index]['idBao'],
                                                );
                                              },
                                              icon: Icon(
                                                Icons.delete,
                                                color: Colors.red,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => const CreateTitle()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
