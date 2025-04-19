import 'package:flutter/material.dart';
import 'package:flutter_project_group4/screens/find.dart';
import 'package:flutter_project_group4/widgets/hot.dart';
import 'package:flutter_project_group4/widgets/new.dart';
import 'package:flutter_project_group4/widgets/vietnamfootball.dart';
import 'package:intl/intl.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    TabIndicatorAnimation tabIndicatorAnimation = TabIndicatorAnimation.elastic;
    return DefaultTabController(
      length: 9, // Số lượng tab
      child: Column(
        children: [
          AppBar(
            toolbarHeight: 100,
            backgroundColor: Colors.blue,
            title: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TabBar(
                        dividerHeight: 0,
                        indicatorAnimation: tabIndicatorAnimation,
                        labelStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        unselectedLabelStyle: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                        isScrollable: true,
                        labelColor: Colors.white,
                        indicatorColor: Colors.white,
                        tabs: [
                          Tab(text: 'Nóng'),
                          Tab(text: 'Mới'),
                          Tab(text: 'Bóng đá VN'),
                          Tab(text: 'Bóng đá QT'),
                          Tab(text: 'Độc & Lạ'),
                          Tab(text: 'Tình Yêu'),
                          Tab(text: 'Giải trí'),
                          Tab(text: 'Thế giới'),
                          Tab(text: 'Pháp luật'),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const FindingScreen()));
                        },
                        icon: Icon(
                          Icons.search,
                          color: Colors.white,
                        ))
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.date_range, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      formattedDate,
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                HotWidget(),
                NewWidget(),
                VietNamFootBall(),
                InternationalFootball(),
                Center(child: Text('Nội dung Hot')),
                Center(child: Text('Nội dung Hot')),
                Center(child: Text('Nội dung Top')),
                Center(child: Text('Nội dung Mới')),
                Center(child: Text('Nội dung Hot')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
