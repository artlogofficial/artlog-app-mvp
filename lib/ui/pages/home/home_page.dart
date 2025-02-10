import 'package:artlog_app_mvp/ui/widgets/navigation/bottom_navigation.dart';
import 'package:artlog_app_mvp/ui/widgets/appbars/custom_appbar.dart';
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
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        type: AppBarType.main,
        title: '',
        showBackButton: false,
        onAlarmPressed: () {
          // 알람 아이콘 클릭시 실행될 로직
        },
      ),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).padding.top + kToolbarHeight),
            // 메인 컨텐츠 중앙 정렬
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "오늘 전시를 기록해 보세요.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // 포스터 이미지 중앙 정렬
                  Center(
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

                  // NOW, LOOK, DEEP 버튼 (중앙 정렬)
                  _buildRecordButton("NOW", "가볍게 기록"),
                  _buildRecordButton("LOOK", "보이는대로 기록"),
                  _buildRecordButton("DEEP", "성찰하며 기록"),
                ],
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigation(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }

  Widget _buildRecordButton(String title, String subtitle) {
    return Center(
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