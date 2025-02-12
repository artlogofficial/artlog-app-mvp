import 'package:artlog_app_mvp/ui/pages/ex_register/ex_location_search_page.dart';
import 'package:artlog_app_mvp/ui/widgets/common/image_uploader.dart';
import 'package:flutter/material.dart';
import 'package:artlog_app_mvp/ui/widgets/appbars/custom_appbar.dart';
import 'package:artlog_app_mvp/ui/widgets/cards/ex_register_card.dart';
import 'package:artlog_app_mvp/ui/widgets/buttons/contained_button.dart';

class ExRegisterPage extends StatefulWidget {
  @override
  _ExRegisterPageState createState() => _ExRegisterPageState();
}

class _ExRegisterPageState extends State<ExRegisterPage> {
  final TextEditingController exhibitionNameController =
      TextEditingController();
  final TextEditingController artistNameController = TextEditingController();

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

                // 📌 전시장소 입력 (기존 방식 유지)
                ExRegisterCard(
                  title: "전시 장소",
                  hintText: "장소명 검색",
                  leadingIcon: Icon(Icons.search, color: Colors.grey),
                  onTap: () async {
                    final selectedLocation = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LocationSearchPage()),
                    );

                    if (selectedLocation != null) {
                      // TODO: 선택한 장소를 상태에 반영 (ex: setState 사용)
                      print("선택한 장소: $selectedLocation");
                    }
                  },
                ),
                const SizedBox(height: 16),

                // 📌 작가명 입력 (TextField, 선택 항목)
                ExRegisterCard(
                  title: "작가 명",
                  optionalHint: "(선택)", // "선택" 표시 추가
                  isTextField: true,
                  hintText: "작가명을 입력하세요",
                  controller: artistNameController,
                ),
                const SizedBox(height: 16),

                // 📌 전시기간 입력 (기존 방식 유지)
                ExRegisterCard(
                  title: "전시 기간",
                  optionalHint: "(선택)", // "선택" 표시 추가
                  leadingIcon:
                      const Icon(Icons.calendar_today, color: Colors.grey),
                  onTap: () {
                    // TODO: 캘린더 기능 추가
                  },
                ),
                const SizedBox(height: 32),

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
