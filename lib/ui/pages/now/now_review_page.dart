import 'package:artlog_app_mvp/ui/pages/archive/archive_page.dart';
import 'package:artlog_app_mvp/ui/widgets/appbars/custom_appbar.dart';
import 'package:artlog_app_mvp/ui/widgets/cards/input_card.dart';
import 'package:flutter/material.dart';
import 'package:artlog_app_mvp/ui/widgets/buttons/contained_button.dart';
import 'package:artlog_app_mvp/ui/widgets/common/image_uploader.dart';
import 'package:artlog_app_mvp/ui/widgets/icons/icon_widgets.dart';
import 'package:artlog_app_mvp/ui/widgets/common/rating_widget.dart'; // 별점 위젯 추가

class NowReviewPage extends StatefulWidget {
  @override
  _NowReviewPageState createState() => _NowReviewPageState();
}

class _NowReviewPageState extends State<NowReviewPage> {
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

            // 내 취향 별점 (RatingWidget 적용)
            CommonCard(
              title: "내 취향 별점",
              child: Column(
                children: [
                  RatingWidget(
                    initialRating: selectedRating,
                    starSize: 48,
                    onRatingChanged: (newRating) {
                      setState(() {
                        selectedRating = newRating;
                      });
                    },
                  ),
                  SizedBox(height: 8),
                  Text(
                    "💙 이런 전시만 하면 좋겠다!! 💙",
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      height: 1.5,
                      letterSpacing: 0,
                      color: Color(0xFF222222),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),

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
                          child: Image.network(image,
                              width: 90, height: 90, fit: BoxFit.cover),
                        ),
                        Positioned(
                          right: 4,
                          top: 4,
                          child: GestureDetector(
                            onTap: () => _removeImage(index),
                            child:
                                Icon(Icons.cancel, size: 20, color: Colors.red),
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
            SizedBox(height: 8),

            // 나만의 특별한 영감 한줄
            CommonCard(
              title: "나만의 특별한 영감 한줄",
              child: Container(
                width: double.infinity,
                height: 120,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(0xFFF7F7F7),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: inspirationController,
                        maxLength: 100,
                        maxLines: null, // 여러 줄 입력 가능
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                            hintText: "나의 영감을 한 줄로 기록하고 \n오래 기억하세요.",
                            hintStyle: TextStyle(
                              color: Color(0xFF9E9E9E),
                              fontSize: 16,
                            ),
                            border: InputBorder.none,
                            counterStyle: TextStyle(
                              // 글자 카운터 스타일 조정(0/100)
                              color: Color(0xFF9E9E9E),
                              fontSize: 12,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 8),

            // 공유 체크 UI (세로 정렬 수정)
            Container(
              width: 328,
              height: 83,
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // 텍스트와 체크박스를 위쪽 정렬
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 2), // 체크박스를 살짝 내림
                    child: Checkbox(
                      value: isShared,
                      activeColor: const Color(0xFF0770E8),
                      materialTapTargetSize:
                          MaterialTapTargetSize.shrinkWrap, // 크기 조정
                      visualDensity: VisualDensity.compact, // 체크박스 크기 축소
                      onChanged: (value) {
                        setState(() {
                          isShared = value!;
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 12), // 체크박스와 텍스트 사이 간격 조정
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '영감 공유하기',
                        style: TextStyle(
                          color: Color(0xFF222222),
                          fontSize: 16,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                          height: 1.50,
                        ),
                      ),
                      SizedBox(height: 4), // 문구 사이 간격 조정
                      Text(
                        '체크하면 다른 사람들이 볼 수 있어요.',
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
                ],
              ),
            ),
            SizedBox(height: 24),

            // 저장 버튼
            ContainedButton(
              text: "저장",
              onPressed: () {
                print(
                    "저장됨 - 별점: $selectedRating, 메모: ${inspirationController.text}, 공유: $isShared");
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ArchivePage(),
                  ),
                );
              },
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
