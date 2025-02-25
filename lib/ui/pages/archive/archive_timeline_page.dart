import 'package:flutter/material.dart';
import 'package:artlog_app_mvp/ui/widgets/appbars/custom_appbar.dart';
import 'package:artlog_app_mvp/ui/widgets/navigation/bottom_navigation.dart';
import 'package:artlog_app_mvp/ui/widgets/common/page_title.dart';

class ArchiveTimelinePage extends StatefulWidget {
  @override
  _ArchiveTimelinePageState createState() => _ArchiveTimelinePageState();
}

class _ArchiveTimelinePageState extends State<ArchiveTimelinePage> {
  int _currentIndex = 1; // 아카이브 탭 인덱스

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildCustomAppBar(),
      body: _buildBodyContent(),
      bottomNavigationBar: BottomNavigation(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }

  // 메인 앱바 적용
  PreferredSizeWidget _buildCustomAppBar() {
    return CustomAppBar(
      type: AppBarType.main,
      title: '',
      showBackButton: false,
      onAlarmPressed: () {
        // 알람 아이콘 클릭 시 실행될 로직
      },
    );
  }

  Widget _buildBodyContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          const PageTitle(title: "나만의 예술취향 아카이브"),
          const SizedBox(height: 12),

          // 정렬 필터 드롭다운
          _buildSortDropdown(),
          const SizedBox(height: 8),

          // 기록 리스트
          Expanded(child: _buildRecordList()),
        ],
      ),
    );
  }

  // 최신 등록순 필터 드롭다운
  Widget _buildSortDropdown() {
    return Container(
      width: 160,
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Color(0xFFE0E0E0)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: "최신 등록순",
          items: ["최신 등록순", "오래된 순"].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: TextStyle(fontSize: 14)),
            );
          }).toList(),
          onChanged: (value) {},
        ),
      ),
    );
  }

  // 기록 리스트
  Widget _buildRecordList() {
    return ListView(
      children: [
        _buildRecordItem("2025", "JAN", "10", "Fish & Chips",
            "마치 심해 속 바다에서 내가 유영하고 있는 듯한 느낌을 받는다. 고요하고 선명한 구조의 아름다움.",
            "https://via.placeholder.com/80"),
        _buildRecordItem("2025", "JAN", "9", "Fish & Chips",
            "마치 심해 속 바다에서 내가 유영하고 있는 듯한 느낌을 받는다. 고요하고 선명한 구조의 아름다움.",
            "https://via.placeholder.com/80"),
        _buildRecordItem("2025", "JAN", "8", "인간, 물질 그리고 변형",
            "마치 심해 속 바다에서 내가 유영하고 있는 듯한 느낌을 받는다. 고요하고 선명한 구조의 아름다움.",
            "https://via.placeholder.com/80"),
      ],
    );
  }

  // 개별 기록 아이템 UI
  Widget _buildRecordItem(String year, String month, String day, String title,
      String description, String imageUrl) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 날짜
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(year, style: _dateTextStyle(12, FontWeight.w400)),
              Text(month, style: _dateTextStyle(14, FontWeight.w600)),
              Text(day, style: _dateTextStyle(20, FontWeight.w700)),
            ],
          ),
          const SizedBox(width: 12),

          // 기록 카드
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // 이미지
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(imageUrl, width: 80, height: 80, fit: BoxFit.cover),
                  ),
                  const SizedBox(width: 12),

                  // 텍스트 정보
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // NOW 태그 & 별점
                        Row(
                          children: [
                            _buildNowTag(),
                            const SizedBox(width: 6),
                            _buildStars(5),
                          ],
                        ),
                        const SizedBox(height: 4),

                        // 전시 제목
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),

                        // 감상 기록
                        Text(
                          description,
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF5B5B5B),
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),

                  // 메뉴 버튼 (더보기)
                  Icon(Icons.more_vert, color: Color(0xFF5B5B5B)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // NOW 태그
  Widget _buildNowTag() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Color(0xFFF52D56),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        "NOW",
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // 별점 표시
  Widget _buildStars(int rating) {
    return Row(
      children: List.generate(5, (index) {
        return Icon(
          Icons.star,
          size: 14,
          color: index < rating ? Color(0xFFFFBC22) : Color(0xFFE0E0E0),
        );
      }),
    );
  }

  // 날짜 텍스트 스타일
  TextStyle _dateTextStyle(double size, FontWeight weight) {
    return TextStyle(
      fontSize: size,
      fontWeight: weight,
      color: Color(0xFF222222),
    );
  }
}