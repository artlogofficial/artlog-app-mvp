import 'dart:io';  // 플랫폼 체크를 위해 필요
import 'package:artlog_app_mvp/ui/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import '../../widgets/login_button.dart'; 

class LoginPage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance; // Firebase 인증 인스턴스

  Future<void> _kakaoLogin(BuildContext context) async {
    try {
      OAuthToken token = await UserApi.instance.loginWithKakaoAccount();

      var provider = OAuthProvider('oidc.kakao_login');
      var credential = provider.credential(
        idToken: token.idToken ?? "", // null이면 빈 문자열로 처리
        accessToken: token.accessToken,
      );

      await _auth.signInWithCredential(credential);

      // 로그인 성공 시 홈화면으로 이동
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()), // HomePage 직접 호출
      );
    } catch (error) {
      print("카카오 로그인 실패: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("카카오 로그인 실패: $error")),
      );
    }
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
          // 로그인 UI
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              const Text(
                "나만의 예술취향을\n기록하고 발견하세요",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              // 카카오 로그인 버튼 (모든 플랫폼 공통)
              LoginButton(
                text: "카카오톡으로 시작하기",
                color: Colors.yellow,
                textColor: Colors.black,
                onPressed: () => _kakaoLogin(context),
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