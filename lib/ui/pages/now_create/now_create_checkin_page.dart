import 'package:artlog_app_mvp/ui/widgets/buttons/contained_button.dart';
import 'package:artlog_app_mvp/ui/widgets/cards/ex_register_card.dart';
import 'package:artlog_app_mvp/ui/widgets/common/image_uploader.dart';
import 'package:artlog_app_mvp/ui/widgets/icons/icon_widgets.dart';
import 'package:flutter/material.dart';
import 'package:artlog_app_mvp/ui/widgets/appbars/custom_appbar.dart';

class NowCreatePage extends StatefulWidget {
  @override
  _NowCreatePageState createState() => _NowCreatePageState();
}

class _NowCreatePageState extends State<NowCreatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "NOW 기록",
        type: AppBarType.sub,
        showBackButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 사진 업로드 위젯 추가
            Center(child: ImageUploader()),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 20),
                Text(
                  'Fish & Chips',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF222222),
                    fontSize: 18,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 8),
                AppIcons.modify(size: 20, color: Colors.grey),
              ],
            ),
            SizedBox(height: 8),
            Text(
              'SUPERFLEX',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF5B5B5B),
                fontSize: 14,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w400,
                height: 1.50,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '국제갤러리',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF5B5B5B),
                    fontSize: 14,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  '~24.03.31',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF5B5B5B),
                    fontSize: 14,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
                // 체크인 날짜 입력
                ExRegisterCard(
                  title: "체크인",
                  isTextField: true,
                  hintText: "방문일자",
                ),
                const SizedBox(height: 10),
            // 다음 버튼
            Center(
              child: ContainedButton(
                text: "다음",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            NowCreatePage()), // 전시 감상 기록 페이지로 이동
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
