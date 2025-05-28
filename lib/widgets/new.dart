import 'package:flutter/material.dart';

class NewWidget extends StatefulWidget {
  const NewWidget({super.key});

  @override
  State<NewWidget> createState() => _NewWidget();
}

class _NewWidget extends State<NewWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
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
    );
  }
}
