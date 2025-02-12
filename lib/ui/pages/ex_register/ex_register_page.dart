import 'package:flutter/material.dart';
import 'package:artlog_app_mvp/ui/widgets/appbars/custom_appbar.dart';
import 'package:artlog_app_mvp/ui/widgets/cards/ex_register_card.dart';

class ExRegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "전시정보 등록",
        type: AppBarType.sub,
        showBackButton: true,
      ),
      body: SingleChildScrollView( // 스크롤뷰 추가
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 24),

              // 📌 사진 추가 영역
              Container(
                width: 120,
                height: 120,
                decoration: ShapeDecoration(
                  color: Color(0xFFF7F7F7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.camera_alt, size: 32, color: Colors.grey),
                    const SizedBox(height: 8),
                    Text(
                      "사진 추가",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 📌 전시명 입력
              ExRegisterCard(
                title: "전시 명",
                hintText: "fish&chips",
              ),
              const SizedBox(height: 16),

              // 📌 작가명 입력
              ExRegisterCard(
                title: "작가 명",
                hintText: "선택",
                trailing: Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                onTap: () {
                  // TODO: 작가명 선택 기능 추가
                },
              ),
              const SizedBox(height: 16),

              // 📌 전시장소 입력
              ExRegisterCard(
                title: "전시 장소",
                hintText: "장소명 검색",
                trailing: Icon(Icons.search, color: Colors.grey),
                onTap: () {
                  // TODO: 장소 검색 기능 추가
                },
              ),
              const SizedBox(height: 16),

              // 📌 전시 기간 입력
              ExRegisterCard(
                title: "전시 기간",
                hintText: "선택",
                trailing: Icon(Icons.calendar_today, color: Colors.grey),
                onTap: () {
                  // TODO: 캘린더 기능 추가
                },
              ),
              const SizedBox(height: 32),

              // 📌 "다음" 버튼
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF00C851),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    // TODO: 다음 단계로 이동
                  },
                  child: Text(
                    "다음",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32), // 여백 추가
            ],
          ),
        ),
      ),
    );
  }
}