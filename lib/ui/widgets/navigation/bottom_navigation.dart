import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavigation({Key? key, required this.currentIndex, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.book), label: '기록'),
        BottomNavigationBarItem(icon: Icon(Icons.archive), label: '아카이브'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: '마이 프로필'),
      ],
    );
  }
}