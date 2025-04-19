import 'package:flutter/material.dart';

class MyAccountScreen extends StatelessWidget {
  const MyAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          toolbarHeight: 50,
          title: Center(
            child: Column(
              children: [
                Text(
                  'Cá nhân',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Divider(height: 0.1),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
