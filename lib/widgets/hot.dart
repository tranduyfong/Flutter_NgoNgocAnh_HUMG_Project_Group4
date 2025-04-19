import 'package:flutter/material.dart';

class HotWidget extends StatefulWidget {
  const HotWidget({super.key});

  @override
  State<HotWidget> createState() => _HotWidgetState();
}

class _HotWidgetState extends State<HotWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
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
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                        flex: 10,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            Container(width: 300, color: Colors.red),
                            SizedBox(
                              width: 20,
                            ),
                            Container(width: 300, color: Colors.blue),
                            SizedBox(
                              width: 20,
                            ),
                            Container(width: 300, color: Colors.green),
                            SizedBox(
                              width: 20,
                            ),
                            Container(width: 300, color: Colors.yellow),
                            SizedBox(
                              width: 20,
                            ),
                            Container(width: 300, color: Colors.orange),
                            SizedBox(
                              width: 20,
                            ),
                            Container(width: 300, color: Colors.red),
                            SizedBox(
                              width: 20,
                            ),
                            Container(width: 300, color: Colors.blue),
                          ],
                        ))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      ListView.builder(
          itemCount: 100,
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
                Divider(
                  height: 5,
                )
              ],
            );
          })
    ]);
  }
}
