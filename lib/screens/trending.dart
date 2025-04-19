import 'package:flutter/material.dart';

class TrendingScreen extends StatelessWidget {
  const TrendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AppBar(
          toolbarHeight: 50,
          backgroundColor: Colors.blue,
          title: Center(
            child: Text('Xu hướng', style: TextStyle(color: Colors.white)),
          ),
        ),
        Center(child: Text('Title of Trending')),
      ],
    );
  }
}
