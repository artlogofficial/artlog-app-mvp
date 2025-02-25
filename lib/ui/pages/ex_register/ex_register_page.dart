import 'package:artlog_app_mvp/ui/pages/ex_register/ex_date_%08selection_sheet.dart';
import 'package:artlog_app_mvp/ui/pages/ex_register/ex_location_search_page.dart';
import 'package:artlog_app_mvp/ui/pages/now/now_checkin_page.dart';
import 'package:artlog_app_mvp/ui/widgets/common/image_uploader.dart';
import 'package:flutter/material.dart';
import 'package:artlog_app_mvp/ui/widgets/appbars/custom_appbar.dart';
import 'package:artlog_app_mvp/ui/widgets/cards/%08common_card.dart';
import 'package:artlog_app_mvp/ui/widgets/buttons/contained_button.dart';
import 'package:intl/intl.dart';

class ExRegisterPage extends StatefulWidget {
  @override
  _ExRegisterPageState createState() => _ExRegisterPageState();
}

class _ExRegisterPageState extends State<ExRegisterPage> {
  final TextEditingController exhibitionNameController =
      TextEditingController();
  final TextEditingController artistNameController = TextEditingController();

  DateTime? selectedStartDate;
  DateTime? selectedEndDate;
  String? selectedLocation;

  String get formattedDateRange {
    if (selectedStartDate != null && selectedEndDate != null) {
      return "${DateFormat('yyyy.MM.dd').format(selectedStartDate!)} - ${DateFormat('yyyy.MM.dd').format(selectedEndDate!)}";
    }
    return "";
  }

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

                // 사진 추가 / 이미지 업로드 영역
                ImageUploader(),
                const SizedBox(height: 24),

                // 전시명 입력 (TextField)
                CommonCard(
                  title: "전시 명",
                  isTextField: true,
                  hintText: "전시명을 입력하세요",
                  controller: exhibitionNameController,
                ),
                const SizedBox(height: 10),

                // 전시장소 입력 (선택 시 검정색 표시)
                CommonCard(
                  title: "전시 장소",
                  hintText: selectedLocation ?? "장소명 검색",
                  hasValue: selectedLocation != null, // 값이 있으면 검정색 적용
                  leadingIcon: Icon(Icons.search, color: Colors.grey),
                  onTap: () async {
                    final location = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LocationSearchPage()),
                    );

                    if (location != null) {
                      setState(() {
                        selectedLocation = location;
                      });
                    }
                  },
                ),
                const SizedBox(height: 10),

                // 작가명 입력 (TextField, 선택 항목)
                CommonCard(
                  title: "작가 명",
                  optionalHint: "(선택)",
                  isTextField: true,
                  hintText: "작가명을 입력하세요",
                  controller: artistNameController,
                ),
                const SizedBox(height: 10),

                // 전시기간 입력 (선택 시 검정색 표시)
                CommonCard(
                  title: "전시 기간",
                  optionalHint: "(선택)",
                  hintText: formattedDateRange.isNotEmpty
                      ? formattedDateRange
                      : "기간 선택",
                  hasValue: formattedDateRange.isNotEmpty, // 값이 있으면 검정색 적용
                  leadingIcon:
                      const Icon(Icons.calendar_today, color: Colors.grey),
                  onTap: () {
                    DatePickerBottomSheet.show(
                      context,
                      initialStartDate: selectedStartDate,
                      initialEndDate: selectedEndDate,
                      onDateSelected: (startDate, endDate) {
                        setState(() {
                          selectedStartDate = startDate;
                          selectedEndDate = endDate;
                        });
                      },
                      isSingleSelection: false, // 전시 기간 선택이므로 false 유지
                    );
                  },
                ),
                const SizedBox(height: 24),

                // "다음" 버튼 - 중앙 정렬
                Center(
                  child: ContainedButton(
                    text: "다음",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                NowCheckinPage()), // 전시 감상 기록 페이지로 이동
                      );
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