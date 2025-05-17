import 'package:flutter/material.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreen();
}

class _FavouritesScreen extends State<FavouritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Stack(
          children: [
            AppBar(
              title: Text(
                'Yêu thích',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Divider(
                height: 1,
                color: const Color.fromARGB(255, 166, 165, 165),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
          Text('Hello'),
          ]),
      ),
    );
  }
}
