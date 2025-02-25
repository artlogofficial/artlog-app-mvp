import 'package:artlog_app_mvp/ui/widgets/appbars/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:artlog_app_mvp/ui/widgets/buttons/contained_button.dart';
import 'package:artlog_app_mvp/ui/widgets/common/rating_widget.dart';
import 'package:artlog_app_mvp/ui/widgets/common/image_uploader.dart';
import 'package:artlog_app_mvp/ui/widgets/icons/icon_widgets.dart';

class NowCreateReviewPage extends StatefulWidget {
  @override
  _NowCreateReviewPageState createState() => _NowCreateReviewPageState();
}

class _NowCreateReviewPageState extends State<NowCreateReviewPage> {
  int selectedRating = 4; // 기본 별점 값
  final TextEditingController inspirationController = TextEditingController();
  bool isShared = true; // 공유 체크 여부

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "NOW 기록",
        type: AppBarType.sub,
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        // 스크롤 가능하도록 변경
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 사진 업로드 위젯 추가
            Center(child: ImageUploader()),
            SizedBox(height: 16),

            // 전시 정보
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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

            // 내 취향 별점
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Text(
                    "내 취향 별점",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 8),
                  RatingWidget(
                    initialRating: selectedRating,
                    onRatingChanged: (newRating) {
                      setState(() {
                        selectedRating = newRating;
                      });
                    },
                  ),
                  SizedBox(height: 8),
                  Text("💙 이런 전시만 하면 좋겠다!! 💙"),
                ],
              ),
            ),
            SizedBox(height: 24),

            // 영감 메모 입력
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: TextField(
                controller: inspirationController,
                maxLength: 100,
                decoration: InputDecoration(
                  hintText: "나의 영감을 한 줄로 기록하고 오래 기억하세요.",
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: 24),

            // 공유 체크박스
            Row(
              children: [
                Checkbox(
                  value: isShared,
                  activeColor: Colors.green,
                  onChanged: (value) {
                    setState(() {
                      isShared = value!;
                    });
                  },
                ),
                Text("영감 공유하기"),
              ],
            ),
            SizedBox(height: 24),

            // 저장 버튼
            ContainedButton(
              text: "저장",
              onPressed: () {
                print(
                    "저장됨 - 별점: $selectedRating, 메모: ${inspirationController.text}, 공유: $isShared");
              },
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
