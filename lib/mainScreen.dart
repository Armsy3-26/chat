import 'package:chat/chat.dart';
import 'package:chat/main.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final tabs = <Widget>[
    const MyHomePage(title: 'cosma'),
    const ChatPage(),
    const MyHomePage(title: 'cosma'),
    const ChatPage(),
  ];

  late PageController _pageController;
  int currentTab = 1;

  goToTab(int page) {
    setState(() {
      currentTab = page;
    });

    _pageController.jumpToPage(page);
  }

  @override
  void initState() {
    _pageController = PageController(initialPage: 1);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Messaging Feature"),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent.withAlpha(155),
        elevation: 0,
        notchMargin: 5,
        child: Container(
          height: 60,
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20.0)),
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _bottomAppBarItem(icon: Icons.home, page: 0),
              _bottomAppBarItem(icon: Icons.message, page: 1),
              _bottomAppBarItem(icon: Icons.notification_add, page: 2),
              _bottomAppBarItem(icon: Icons.category, page: 3),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        mini: true,
        onPressed: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const ChatPage()));
        },
        tooltip: 'OutReach',
        child: const Icon(Icons.message),
      ),
    );
  }

  Widget _bottomAppBarItem({icon, page}) {
    return IconButton(
      splashRadius: 20,
      onPressed: () => goToTab(page),
      icon: Icon(
        icon,
        color: currentTab == page ? Colors.amber : Colors.blueGrey.shade200,
        size: 22,
      ),
    );
  }
}
