import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 배경 이미지
          Image.asset(
            'assets/images/splash_screen.png',  // 배경 이미지 경로
            fit: BoxFit.cover,           // 전체 화면에 맞춤
          ),
          // 로고 이미지 (중앙 배치)
          Center(
            child: Image.asset(
              'assets/images/artlog_logo.png',   // 로고 이미지 경로
              width: 150,                 // 로고 크기 조정 (원하는 크기로 변경 가능)
            ),
          ),
        ],
      ),
    );
  }
}