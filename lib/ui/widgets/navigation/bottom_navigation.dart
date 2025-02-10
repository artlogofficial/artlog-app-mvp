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
      backgroundColor: Colors.white,
      selectedItemColor: const Color.fromRGBO(74, 92, 227, 1), // 선택된 아이콘 색상 (brand_blue)
      unselectedItemColor: const Color.fromRGBO(158, 158, 158, 1), // 선택되지 않은 아이콘 색상 (gray-500)
      showSelectedLabels: false, // 기본 라벨 숨김
      showUnselectedLabels: false, // 기본 라벨 숨김

      items: [
        _buildNavItem(Icons.edit, "기록", 0, currentIndex),
        _buildNavItem(Icons.calendar_today, "아카이브", 1, currentIndex),
        _buildNavItem(Icons.person, "마이 프로필", 2, currentIndex),
      ],
    );
  }

  BottomNavigationBarItem _buildNavItem(IconData icon, String label, int index, int currentIndex) {
    final isSelected = currentIndex == index;

    return BottomNavigationBarItem(
      icon: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center, 
        children: [
          SizedBox(
            width: 32,
            height: 32,
            child: Center(
              child: Icon(
                icon, 
                size: 24,
                color: isSelected 
                    ? const Color.fromRGBO(74, 92, 227, 1) 
                    : const Color.fromRGBO(158, 158, 158, 1),
              ),
            ),
          ),
          const SizedBox(height: 1), // 아이콘과 텍스트 간 여백
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w700,
              fontSize: 11,
              height: 14 / 11,
              letterSpacing: 0,
              color: isSelected 
                  ? const Color.fromRGBO(74, 92, 227, 1) 
                  : const Color.fromRGBO(158, 158, 158, 1),
            ),
          ),
        ],
      ),
      label: '',
    );
  }
}