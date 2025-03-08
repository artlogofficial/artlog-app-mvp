import 'package:artlog_app_mvp/ui/widgets/navigation/bottom_navigation.dart';
import 'package:artlog_app_mvp/ui/widgets/appbars/custom_appbar.dart';
import 'package:artlog_app_mvp/ui/widgets/common/page_title.dart';
import 'package:flutter/material.dart';
import 'package:artlog_app_mvp/ui/pages/ex_search/ex_search_page.dart';

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
      appBar: _buildCustomAppBar(),
      body: _buildBodyContent(),
      bottomNavigationBar: BottomNavigation(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }

  // 앱바위젯 사용
  PreferredSizeWidget _buildCustomAppBar() {
    return CustomAppBar(
      type: AppBarType.main,
      title: '',
      showBackButton: false,
      onAlarmPressed: () {
        // 알람 아이콘 클릭 시 실행될 로직
      },
    );
  }

  Widget _buildBodyContent() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: _buildGradientDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top + kToolbarHeight),
          const Align(
            alignment: Alignment.centerLeft,
            child: PageTitle(title: "오늘 전시를 기록해 보세요."),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                _buildPosterImage(),
                const SizedBox(height: 0),
                _buildRecordButton("NOW", "가볍게 기록", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ExSearchPage()), // NOW 버튼 클릭 시 이동
                  );
                }),
                const SizedBox(height: 6),
                _buildRecordButton("LOOK", "보이는대로 기록", () {}),
                const SizedBox(height: 6),
                _buildRecordButton("DEEP", "성찰하며 기록", () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 그라디언트 배경
  BoxDecoration _buildGradientDecoration() {
    return const BoxDecoration(
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
    );
  }

  // 포스터 이미지
  Widget _buildPosterImage() {
    return Center(
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
    );
  }

  // 기록 버튼 위젯 (이제 onTap 기능 추가됨)
  Widget _buildRecordButton(String title, String subtitle, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap, // 버튼 클릭 시 함수 실행
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: title == "NOW" ? 0 : 6),
        child: Container(
          width: 328,
          height: 70,
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