import 'package:artlog_app_mvp/firebase_options.dart';
import 'package:artlog_app_mvp/ui/pages/ex_search/ex_search_page.dart';
import 'package:artlog_app_mvp/ui/pages/home/home_page.dart';
import 'package:artlog_app_mvp/ui/pages/login/login_page.dart';
import 'package:artlog_app_mvp/ui/pages/splash/splash_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_template.dart';
import 'package:artlog_app_mvp/upload_json.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // 파이어베이스 초기화
  );

  // Firestore에 JSON 데이터 자동 업로드
  UploadJsonService uploadService = UploadJsonService();
  // ✅ 전시 정보 업로드
  await uploadService.uploadExhibitionsToFirestore();
  // ✅ 갤러리 정보 업로드
  await uploadService.uploadGalleriesToFirestore();

  KakaoSdk.init(
    nativeAppKey: '076ca6243ce1d2beff696c34423eefac',
    javaScriptAppKey: '3a72d5c2a733b185eb6458afae8a4d17', // 카카오 SDK 초기화
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ArtLog',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainPage(), // 첫 화면을 MainPage로 설정
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Page'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SplashPage()),
                );
              },
              child: const Text('스플래시 화면'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: const Text('로그인 화면'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ExSearchPage()),
                );
              },
              child: const Text('전시검색 화면'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              child: const Text('홈화면'),
            ),
          ],
        ),
      ),
    );
  }
}
