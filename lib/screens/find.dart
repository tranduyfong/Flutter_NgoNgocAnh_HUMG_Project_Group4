import 'package:flutter/material.dart';

class FindingScreen extends StatefulWidget {
  const FindingScreen({super.key});

  @override
  State<FindingScreen> createState() => _FindingScreenState();
}

class _FindingScreenState extends State<FindingScreen> {
  final TextEditingController textEditingController = TextEditingController();

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
      body: Center(
        child:
            textEditingController.text.isEmpty
                ? Center(child: Text('Chưa có thông tin nhập vào'))
                : Center(
                  child: Text('Bạn vừa nhập vào ${textEditingController.text}'),
                ),
      ),
    );
  }
}
