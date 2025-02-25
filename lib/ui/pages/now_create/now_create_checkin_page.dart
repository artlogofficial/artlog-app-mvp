import 'package:artlog_app_mvp/ui/pages/ex_register/ex_date_%08selection_sheet.dart';
import 'package:artlog_app_mvp/ui/pages/now_create/now_create_review_page.dart';
import 'package:artlog_app_mvp/ui/widgets/buttons/contained_button.dart';
import 'package:artlog_app_mvp/ui/widgets/cards/%08common_card.dart';
import 'package:artlog_app_mvp/ui/widgets/common/image_uploader.dart';
import 'package:artlog_app_mvp/ui/widgets/icons/icon_widgets.dart';
import 'package:flutter/material.dart';
import 'package:artlog_app_mvp/ui/widgets/appbars/custom_appbar.dart';
import 'package:intl/intl.dart';

class NowCreateCheckinPage extends StatefulWidget {
  @override
  _NowCreatePageState createState() => _NowCreatePageState();
}

class _NowCreatePageState extends State<NowCreateCheckinPage> {
  DateTime? selectedCheckInDate; // 체크인 날짜 상태 변수
  String selectedPerson = "혼자"; // 함께한 사람 기본값

  final List<String> options = [
    "혼자",
    "친구와",
    "연인과",
    "가족과",
    "동료와",
    "모임에서"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "NOW 기록",
        type: AppBarType.sub,
        showBackButton: true,
      ),
      body: SingleChildScrollView( // 스크롤 가능하도록 변경
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

            // 체크인 날짜 입력 (하루만 선택 가능)
            CommonCard(
              title: "체크인",
              hintText: selectedCheckInDate != null
                  ? DateFormat('yyyy.MM.dd').format(selectedCheckInDate!)
                  : "방문일자",
              hasValue: selectedCheckInDate != null,
              leadingIcon: const Icon(Icons.calendar_today, color: Colors.grey),
              onTap: () {
                DatePickerBottomSheet.show(
                  context,
                  initialDate: selectedCheckInDate,
                  onDateSelected: (selected, _) {
                    setState(() {
                      selectedCheckInDate = selected;
                    });
                  },
                  isSingleSelection: true,
                );
              },
            ),
            const SizedBox(height: 24),

            // 함께한 사람 선택 UI
            Container(
              width: 328,
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 상단 제목
                  const Text(
                    '함께한 사람',
                    style: TextStyle(
                      color: Color(0xFF222222),
                      fontSize: 16,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 선택 옵션 (라디오 버튼, 한 줄에 3개씩)
                  Wrap(
                    spacing: 20, // 버튼 간격 조정
                    runSpacing: 12, // 줄바꿈 간격 조정
                    alignment: WrapAlignment.center,
                    children: options.map((option) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width / 3 - 24, // 한 줄에 3개 정렬
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedPerson = option;
                            });
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Radio<String>(
                                value: option,
                                groupValue: selectedPerson,
                                activeColor: const Color(0xFF0770E8), // 선택된 버튼 색상 적용
                                onChanged: (String? value) {
                                  setState(() {
                                    selectedPerson = value!;
                                  });
                                },
                              ),
                              Text(
                                option,
                                style: const TextStyle(
                                  color: Color(0xFF222222),
                                  fontSize: 16,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 다음 버튼
            Center(
              child: ContainedButton(
                text: "다음",
                onPressed: () {
                  Navigator.push(
                    context,
                        MaterialPageRoute(
                            builder: (context) =>
                                NowCreateReviewPage()),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}