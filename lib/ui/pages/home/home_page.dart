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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
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
            crossAxisAlignment: CrossAxisAlignment.center, // ✅ 내부 요소 중앙 정렬
            children: [
              // 🔹 상단 로고 (왼쪽 정렬 유지)
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: Image.asset(
                  'assets/images/artlog_logo.png',
                  height: 30,
                ),
              ),

              // 🔹 메인 컨텐츠 중앙 정렬
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center, // ✅ 내부 요소 중앙 정렬
                  children: [
                    const Text(
                      "오늘 전시를 기록해 보세요.",
                      textAlign: TextAlign.center, // ✅ 텍스트 중앙 정렬
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // 🔹 포스터 이미지 중앙 정렬
                    Center( // ✅ 추가된 부분
                      child: Container(
                        width: 200,
                        height: 300,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/poster.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),

                    // 🔹 NOW, LOOK, DEEP 버튼 (중앙 정렬)
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

      // ✅ 네비게이션 바
      bottomNavigationBar: BottomNavigation(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }

  // 기록 버튼 위젯 (중앙 정렬)
  Widget _buildRecordButton(String title, String subtitle) {
    return Center( // ✅ 버튼 중앙 정렬
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
        child: Container(
          width: 328,
          height: 65,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: ShapeDecoration(
            color: Color(0xFFF2F2F2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 26,
                  fontFamily: 'DungGeunMo',
                  fontWeight: FontWeight.w400,
                  letterSpacing: -1.5,
                ),
              ),
              Row(
                children: [
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Color(0xFF222222),
                      fontSize: 14,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Icon(Icons.arrow_forward_ios, size: 14, color: Colors.black),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}