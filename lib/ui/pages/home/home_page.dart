import 'package:artlog_app_mvp/ui/widgets/navigation/bottom_navigation.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    // TODO: 각 탭에 따라 다른 페이지로 이동하는 로직 추가 가능
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          // 그라데이션 배경
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF4079CA),
              Color(0xFF0276F8),
              Color(0xFF9DC8CE),
              Color(0xFFF782B3),
            ],
            stops: [0.15, 0.4967, 0.7438, 0.894],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 왼쪽 상단 로고
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: Image.asset(
                  'assets/images/artlog_logo.png',
                  height: 30, 
                ),
              ),

              // 메인 컨텐츠
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "오늘 전시를 기록해 보세요.",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
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
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigation(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }

  // 기록 버튼 위젯
  Widget _buildRecordButton(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
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
}