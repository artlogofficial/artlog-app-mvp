import 'package:artlog_app_mvp/ui/pages/archive/timeline_view.dart';
import 'package:artlog_app_mvp/ui/pages/archive/calendar_view.dart';
import 'package:artlog_app_mvp/ui/widgets/common/record_badge.dart';
import 'package:flutter/material.dart';
import 'package:artlog_app_mvp/ui/widgets/appbars/custom_appbar.dart';
import 'package:artlog_app_mvp/ui/widgets/common/page_title.dart';

class ArchivePage extends StatefulWidget {
  @override
  _ArchivePageState createState() => _ArchivePageState();
}

class _ArchivePageState extends State<ArchivePage> {
  int _currentIndex = 1; // 아카이브 탭 인덱스
  bool _isListView = true; // 목록 보기 상태 (true: 리스트, false: 캘린더)
  String _sortOption = '최신 등록순'; // 정렬 옵션 기본값

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

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

  // 정렬 옵션 선택 버튼 (PopupMenuButton)
  Widget _buildSortMenu() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16), // PageTitle과 정렬
      child: Container(
        height: 48, // 고정된 높이
        decoration: BoxDecoration(
          border: _isListView
              ? Border(
                  bottom: BorderSide(
                    width: 1,
                    color: Colors.black.withOpacity(0.1), // 리스트뷰일 때만 테두리 추가
                  ),
                )
              : null, // CalendarView일 때는 테두리 제거
        ),
        child: Row(
          children: [
            // 정렬 옵션 표시 + 팝업 메뉴
            PopupMenuButton<String>(
              color: Colors.white,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      _sortOption,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        height: 21 / 14, // line-height 계산
                        letterSpacing: 0,
                        color: Color(0xFF5B5B5B),
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.keyboard_arrow_down, color: Color(0xFF5B5B5B)),
                  ],
                ),
              ),
              onSelected: (String newValue) {
                setState(() {
                  _sortOption = newValue;
                });
              },
              itemBuilder: (BuildContext context) => [
                const PopupMenuItem(
                  value: '최신 등록순',
                  child: Text('최신 등록순'),
                ),
                const PopupMenuItem(
                  value: '오래된순',
                  child: Text('오래된순'),
                ),
                const PopupMenuItem(
                  value: '별점 높은순',
                  child: Text('별점 높은순'),
                ),
              ],
            ),

            // Spacer를 추가하여 오른쪽 버튼을 끝으로 이동
            const Spacer(),

            // 타임라인-캘린더 뷰 전환 버튼 (오른쪽 끝 정렬)
            Container(
              width: 24,
              height: 24,
              child: IconButton(
                icon: Icon(_isListView ? Icons.view_list : Icons.calendar_month),
                color: const Color.fromRGBO(179, 179, 179, 1),
                padding: EdgeInsets.zero, // 버튼 크기 조정
                constraints: const BoxConstraints(), // 아이콘 크기 조정
                onPressed: () {
                  setState(() {
                    _isListView = !_isListView;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildCustomAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // PageTitle 위젯
          const PageTitle(
            title: "나만의 예술취향 아카이브",
            textAlign: TextAlign.left,
          ),
          // 정렬 옵션과 보기 방식 전환 버튼 (아래 테두리 적용)
          _buildSortMenu(), // PageTitle과 정렬됨
          // 타임라인 뷰 또는 캘린더 뷰
          Expanded(
            child: _isListView
                ? TimelineView()
                : CalendarView(), // CalendarView일 때는 아래 테두리 없음
          ),
        ],
      ),
    );
  }
}