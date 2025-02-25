import 'package:artlog_app_mvp/ui/pages/ex_register/ex_date_%08selection_sheet.dart';
import 'package:artlog_app_mvp/ui/widgets/buttons/contained_button.dart';
import 'package:artlog_app_mvp/ui/widgets/cards/ex_register_card.dart';
import 'package:artlog_app_mvp/ui/widgets/common/image_uploader.dart';
import 'package:artlog_app_mvp/ui/widgets/icons/icon_widgets.dart';
import 'package:flutter/material.dart';
import 'package:artlog_app_mvp/ui/widgets/appbars/custom_appbar.dart';
import 'package:intl/intl.dart';

class NowCreatePage extends StatefulWidget {
  @override
  _NowCreatePageState createState() => _NowCreatePageState();
}

class _NowCreatePageState extends State<NowCreatePage> {
  DateTime? selectedCheckInDate; // 체크인 날짜 상태 변수

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

            // 전시 정보
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

            // 체크인 날짜 입력 (하루만 선택 가능)
            ExRegisterCard(
              title: "체크인",
              hintText: selectedCheckInDate != null
                  ? DateFormat('yyyy.MM.dd').format(selectedCheckInDate!) // 선택된 날짜 표시
                  : "방문일자", // 기본 텍스트
              hasValue: selectedCheckInDate != null, // 값이 있으면 검정색 적용
              leadingIcon: const Icon(Icons.calendar_today, color: Colors.grey), // 아이콘 추가
              onTap: () {
                DatePickerBottomSheet.show(
                  context,
                  initialDate: selectedCheckInDate,
                  onDateSelected: (selected, _) {
                    setState(() {
                      selectedCheckInDate = selected; // 선택한 날짜 저장
                    });
                  },
                  isSingleSelection: true, // 하루만 선택 가능
                );
              },
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
                      builder: (context) => NowCreatePage(),
                    ),
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