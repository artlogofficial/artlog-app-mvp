import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          // ✅ 그라데이션 배경 적용
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF4079CA), // 15%
              Color(0xFF0276F8), // 49.67%
              Color(0xFF9DC8CE), // 74.38%
              Color(0xFFF782B3), // 89.4%
            ],
            stops: [0.15, 0.4967, 0.7438, 0.894], // 각 색상의 위치 설정
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ✅ 왼쪽 상단 로고
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: Image.asset(
                  'assets/images/artlog_logo.png',
                  height: 30, // 로고 크기 조절
                ),
              ),

              // ✅ 메인 컨텐츠
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "오늘 전시를 기록해 보세요.",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // 텍스트 색상
                      ),
                    ),
                    const SizedBox(height: 20),

                    // NOW, LOOK, DEEP 버튼
                    _buildRecordButton("NOW", "가볍게 기록"),
                    _buildRecordButton("LOOK", "보이는대로 기록"),
                    _buildRecordButton("DEEP", "성찰하며 기록"),
                  ],
                ),
              ),

              // ✅ 하단 네비게이션 바
              _buildBottomNavigationBar(),
            ],
          ),
        ),
      ),
    );
  }

  // ✅ 기록 버튼 위젯
  Widget _buildRecordButton(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white, // 버튼 배경색
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        ),
        onPressed: () {
          // TODO: 버튼 클릭 시 이동할 페이지 설정
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ✅ 하단 네비게이션 바
  Widget _buildBottomNavigationBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9), // 반투명 배경
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.book, "기록", isSelected: true),
          _buildNavItem(Icons.archive, "아카이브"),
          _buildNavItem(Icons.person, "마이 프로필"),
        ],
      ),
    );
  }

  // ✅ 네비게이션 아이템
  Widget _buildNavItem(IconData icon, String label, {bool isSelected = false}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: isSelected ? Colors.blue : Colors.black),
        const SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.blue : Colors.black,
          ),
        ),
      ],
    );
  }
}