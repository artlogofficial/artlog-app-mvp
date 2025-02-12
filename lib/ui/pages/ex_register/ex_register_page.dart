import 'package:artlog_app_mvp/ui/pages/ex_register/ex_date_%08selection_sheet.dart';
import 'package:artlog_app_mvp/ui/pages/ex_register/ex_location_search_page.dart';
import 'package:artlog_app_mvp/ui/widgets/common/image_uploader.dart';
import 'package:flutter/material.dart';
import 'package:artlog_app_mvp/ui/widgets/appbars/custom_appbar.dart';
import 'package:artlog_app_mvp/ui/widgets/cards/ex_register_card.dart';
import 'package:artlog_app_mvp/ui/widgets/buttons/contained_button.dart';
import 'package:intl/intl.dart'; // 날짜 포맷을 위해 추가

class ExRegisterPage extends StatefulWidget {
  @override
  _ExRegisterPageState createState() => _ExRegisterPageState();
}

class _ExRegisterPageState extends State<ExRegisterPage> {
  final TextEditingController exhibitionNameController = TextEditingController();
  final TextEditingController artistNameController = TextEditingController();

  String? selectedDateRange; // 선택된 전시 기간을 저장할 상태 변수

  @override
  void dispose() {
    exhibitionNameController.dispose();
    artistNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "전시정보 등록",
        type: AppBarType.sub,
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 24),

                // 📌 사진 추가 / 이미지 업로드 영역
                ImageUploader(),
                const SizedBox(height: 24),

                // 📌 전시명 입력 (TextField)
                ExRegisterCard(
                  title: "전시 명",
                  isTextField: true,
                  hintText: "전시명을 입력하세요",
                  controller: exhibitionNameController,
                ),
                const SizedBox(height: 16),

                // 📌 전시장소 입력
                ExRegisterCard(
                  title: "전시 장소",
                  hintText: "장소명 검색",
                  leadingIcon: Icon(Icons.search, color: Colors.grey),
                  onTap: () async {
                    final selectedLocation = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LocationSearchPage()),
                    );

                    if (selectedLocation != null) {
                      // TODO: 선택한 장소를 상태에 반영
                      print("선택한 장소: $selectedLocation");
                    }
                  },
                ),
                const SizedBox(height: 16),

                // 📌 작가명 입력 (TextField, 선택 항목)
                ExRegisterCard(
                  title: "작가 명",
                  optionalHint: "(선택)",
                  isTextField: true,
                  hintText: "작가명을 입력하세요",
                  controller: artistNameController,
                ),
                const SizedBox(height: 16),

                // 📌 전시기간 입력 (날짜 선택 시 업데이트)
                ExRegisterCard(
                  title: "전시 기간",
                  optionalHint: "(선택)",
                  hintText: selectedDateRange ?? "", // 선택된 날짜 표시, 날짜 선택이 없을 시 텍스트 표시 없음
                  leadingIcon: const Icon(Icons.calendar_today, color: Colors.grey),
                  onTap: () {
                    DatePickerBottomSheet.show(context, (startDate, endDate) {
                      setState(() {
                        selectedDateRange =
                            "${DateFormat('yyyy.MM.dd').format(startDate)} - ${DateFormat('yyyy.MM.dd').format(endDate)}"; // 날짜 포맷 설정
                      });
                    });
                  },
                ),

                // 📌 "다음" 버튼 - 중앙 정렬
                Center(
                  child: ContainedButton(
                    text: "다음",
                    onPressed: () {
                      // TODO: 다음 단계로 이동
                    },
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}