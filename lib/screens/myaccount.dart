import 'package:flutter/material.dart';

class MyAccountScreen extends StatelessWidget {
  const MyAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cá nhân',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.teal[700],
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Color(0xFF4B5563), fontSize: 16),
          titleMedium: TextStyle(
            color: Color(0xFF374151),
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
          bodySmall: TextStyle(color: Color(0xFF374151), fontSize: 16),
          labelSmall: TextStyle(color: Color(0xFF9CA3AF), fontSize: 12),
          labelLarge: TextStyle(
            color: Color(0xFF14B8A6),
            fontWeight: FontWeight.w700,
            fontSize: 12,
            letterSpacing: 1.5,
          ),
        ),
      ),
      home: const PersonalPage(),
    );
  }
}

class PersonalPage extends StatelessWidget {
  const PersonalPage({super.key});

  void _showDialog(
    BuildContext context,
    String title,
    List<Widget> content,
    List<Widget> actions,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Column(mainAxisSize: MainAxisSize.min, children: content),
          actions: actions,
        );
      },
    );
  }

  void _showLoginDialog(BuildContext context) {
    _showDialog(
      context,
      'Đăng nhập',
      [
        TextField(decoration: const InputDecoration(labelText: 'Email')),
        TextField(
          decoration: const InputDecoration(labelText: 'Mật khẩu'),
          obscureText: true,
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
            _showRegisterDialog(context);
          },
          child: const Text(
            'Bạn chưa có tài khoản? Đăng ký',
            style: TextStyle(
              color: Color(0xFF14B8A6),
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.underline,
              fontSize: 14,
            ),
          ),
        ),
      ],
      [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Hủy'),
        ),
        TextButton(
          onPressed: () {
            // Xử lý đăng nhập ở đây
            Navigator.of(context).pop();
          },
          child: const Text('Đăng nhập'),
        ),
      ],
    );
  }

  void _showRegisterDialog(BuildContext context) {
    _showDialog(
      context,
      'Đăng ký',
      [
        TextField(decoration: const InputDecoration(labelText: 'Email')),
        TextField(
          decoration: const InputDecoration(labelText: 'Mật khẩu'),
          obscureText: true,
        ),
        TextField(
          decoration: const InputDecoration(labelText: 'Xác nhận mật khẩu'),
          obscureText: true,
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
            _showLoginDialog(context);
          },
          child: const Text(
            'Bạn đã có tài khoản? Đăng nhập',
            style: TextStyle(
              color: Color(0xFF14B8A6),
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.underline,
              fontSize: 14,
            ),
          ),
        ),
      ],
      [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Hủy'),
        ),
        TextButton(
          onPressed: () {
            // Xử lý đăng ký ở đây
            Navigator.of(context).pop();
          },
          child: const Text('Đăng ký'),
        ),
      ],
    );
  }

  void _navigateToFavorites(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => const FavoritesPage()));
  }

  Widget buildIconText(
    IconData icon,
    String text, {
    Widget? trailing,
    bool isGrayIcon = true,
    double iconSize = 24,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          color: isGrayIcon ? const Color(0xFF9CA3AF) : Colors.teal[700],
          size: iconSize,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(color: Color(0xFF374151), fontSize: 16),
          ),
        ),
        if (trailing != null) trailing,
      ],
    );
  }

  Widget buildSectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 24),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFF14B8A6),
          fontWeight: FontWeight.w700,
          fontSize: 12,
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget lotteryIcon() {
      return Stack(
        clipBehavior: Clip.none,
        children: [
          Icon(Icons.circle_outlined, color: const Color(0xFF9CA3AF), size: 24),
          Positioned(
            top: -6,
            right: -10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
              decoration: const BoxDecoration(color: Colors.transparent),
              child: const Text(
                '39',
                style: TextStyle(
                  fontSize: 10,
                  color: Color(0xFF9CA3AF),
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: const Text(
          'Cá nhân',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 20,
          ),
          onPressed: () {},
          tooltip: 'Back',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ListView(
          children: [
            GestureDetector(
              onTap: () => _showLoginDialog(context),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: const Color(0xFFD1D5DB),
                    child: const Icon(
                      Icons.person,
                      size: 32,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Đăng nhập',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Color(0xFF111827),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            // Four icon grid
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => _navigateToFavorites(context),
                  child: const _IconLabel(
                    icon: Icons.bookmark,
                    label: 'Đã yêu thích',
                    iconColor: Color(0xFF0D9488),
                  ),
                ),
                GestureDetector(
                  onTap: () => debugPrint('Đang theo dõi tapped'),
                  child: const _IconLabel(
                    icon: Icons.check_box,
                    label: 'Đang theo dõi',
                    iconColor: Color(0xFF0D9488),
                  ),
                ),
                GestureDetector(
                  onTap: () => debugPrint('Tin đã tải tapped'),
                  child: const _IconLabel(
                    icon: Icons.download,
                    label: 'Tin đã tải',
                    iconColor: Color(0xFF0D9488),
                  ),
                ),
                GestureDetector(
                  onTap: () => debugPrint('Đọc gần đây tapped'),
                  child: const _IconLabel(
                    icon: Icons.access_time,
                    label: 'Đọc gần đây',
                    iconColor: Color(0xFF0D9488),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _IconLabel extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color iconColor;

  const _IconLabel({
    super.key,
    required this.icon,
    required this.label,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: iconColor, size: 28),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(color: Color(0xFF4B5563), fontSize: 14),
        ),
      ],
    );
  }
}

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  final List<Map<String, String>> favoriteArticles = const [
    {
      'title': 'Bài báo yêu thích 1',
      'summary': 'Tóm tắt ngắn của bài báo yêu thích 1...',
    },
    {
      'title': 'Bài báo yêu thích 2',
      'summary': 'Tóm tắt ngắn của bài báo yêu thích 2...',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đã yêu thích'),
        backgroundColor: Colors.teal[700],
      ),
      body: ListView.builder(
        itemCount: favoriteArticles.length,
        itemBuilder: (context, index) {
          final article = favoriteArticles[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(article['title']!),
              subtitle: Text(article['summary']!),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // TODO: Handle article detail navigation if needed
              },
            ),
          );
        },
      ),
    );
  }
}
