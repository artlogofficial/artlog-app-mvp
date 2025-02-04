import 'dart:io';  // 플랫폼 체크를 위해 필요
import 'package:flutter/material.dart';
import '../../widgets/login_button.dart';  // 로그인 버튼 불러오기

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 배경 이미지
          Image.asset(
            'assets/splash_screen.png',
            fit: BoxFit.cover,
          ),
          // 로그인 UI
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              const Text(
                "너만의 예술취향을\n기록하고 발견하세요",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              // 카카오 로그인 버튼 (모든 플랫폼 공통)
              LoginButton(
                text: "카카오톡으로 시작하기",
                color: Colors.green,
                textColor: Colors.black,
                onPressed: () {
                  // TODO: 카카오 로그인 로직 추가
                },
              ),
              // iOS에서만 표시 (애플 로그인)
              if (Platform.isIOS)
                LoginButton(
                  text: "애플로 시작하기",
                  color: Colors.black,
                  textColor: Colors.white,
                  onPressed: () {
                    // TODO: 애플 로그인 로직 추가
                  },
                ),
              // Android에서만 표시 (구글 로그인)
              if (Platform.isAndroid)
                LoginButton(
                  text: "구글로 시작하기",
                  color: Colors.black,
                  textColor: Colors.white,
                  onPressed: () {
                    // TODO: 구글 로그인 로직 추가
                  },
                ),
              const SizedBox(height: 50),
            ],
          ),
        ],
      ),
    );
  }
}