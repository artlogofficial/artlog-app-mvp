import 'package:artlog_app_mvp/ui/widgets/appbars/custom_appbar.dart';
import 'package:artlog_app_mvp/ui/widgets/cards/%08common_card.dart';
import 'package:flutter/material.dart';
import 'package:artlog_app_mvp/ui/widgets/buttons/contained_button.dart';
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
  List<String> uploadedImages = []; // 업로드된 이미지 리스트

  void _addImage(String imagePath) {
    if (uploadedImages.length < 3) {
      setState(() {
        uploadedImages.add(imagePath);
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      uploadedImages.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "NOW 기록",
        type: AppBarType.sub,
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 사진 업로드 위젯
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
            CommonCard(
              title: "내 취향 별점",
              child: Column(
                children: [
                  SizedBox(
                    width: 272,
                    height: 48,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(5, (index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedRating = index + 1;
                            });
                          },
                          child: Icon(
                            Icons.star,
                            size: 48,
                            color: index < selectedRating
                                ? Color(0xFFFFBC22) // 채워진 별 색상
                                : Color(0xFFE0E0E0), // 빈 별 색상
                          ),
                        );
                      }),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text("💙 이런 전시만 하면 좋겠다!! 💙"),
                ],
              ),
            ),
            SizedBox(height: 24),

            // 작품, 공간, 나 (사진 추가)
            CommonCard(
              title: "작품, 공간, 나",
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  ...uploadedImages.asMap().entries.map((entry) {
                    int index = entry.key;
                    String image = entry.value;
                    return Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(image, width: 90, height: 90, fit: BoxFit.cover),
                        ),
                        Positioned(
                          right: 4,
                          top: 4,
                          child: GestureDetector(
                            onTap: () => _removeImage(index),
                            child: Icon(Icons.cancel, size: 20, color: Colors.red),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                  if (uploadedImages.length < 3)
                    GestureDetector(
                      onTap: () => _addImage("https://via.placeholder.com/90"),
                      child: Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(Icons.camera_alt, color: Colors.grey[600]),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(height: 24),

            // 나만의 특별한 영감 한줄 (회색 박스 사용, 세로 길이 증가)
            CommonCard(
              title: "나만의 특별한 영감 한줄",
              isTextField: true,
              hintText: "나의 영감을 한 줄로 기록하고 오래 기억하세요.",
              controller: inspirationController,
              hasValue: inspirationController.text.isNotEmpty,
              child: TextField(
                controller: inspirationController,
                maxLength: 100,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: "나의 영감을 한 줄로 기록하고 오래 기억하세요.",
                  border: InputBorder.none,
                  counterText: "",
                ),
              ),
            ),
            SizedBox(height: 24),

            // 공유 체크박스
            CheckboxListTile(
              value: isShared,
              activeColor: const Color(0xFF0770E8),
              onChanged: (value) {
                setState(() {
                  isShared = value!;
                });
              },
              title: Text("영감 공유하기"),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            SizedBox(height: 24),

            // 저장 버튼
            ContainedButton(
              text: "저장",
              onPressed: () {
                print("저장됨 - 별점: $selectedRating, 메모: ${inspirationController.text}, 공유: $isShared");
              },
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}