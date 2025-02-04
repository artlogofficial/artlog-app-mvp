import 'package:artlog_app_mvp/ui/pages/login/login_page.dart';
import 'package:flutter/material.dart';
import 'dart:async';


class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  double _opacity = 0.0; // 초기 투명도 설정

  @override
  void initState() {
    super.initState();

    // 애니메이션 시작 (0.5초 후 페이드 인)
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1.0;
      });
    });

    // 2초 후 로그인 페이지로 이동
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginPage()), // LoginPage로 이동
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 배경 이미지
          Image.asset(
            'assets/images/splash_screen.png',  
            fit: BoxFit.cover,                  
          ),
          // 로고 이미지 (페이드 인 애니메이션 적용)
          Center(
            child: AnimatedOpacity(
              duration: Duration(seconds: 1), // 페이드 인 시간
              opacity: _opacity,
              child: Image.asset(
                'assets/images/artlog_logo.png',   
                width: 150, // 로고 크기
              ),
            ),
          ),
          // 앱 버전 정보 (하단 배치)
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Text(
              "v1.0.0-beta.1",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}