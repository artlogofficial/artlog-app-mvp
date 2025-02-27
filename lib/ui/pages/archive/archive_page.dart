import 'package:artlog_app_mvp/ui/pages/archive/timeline_view.dart';
// 새로 만든 calendar_view.dart 파일 경로에 맞춰 import
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
  bool _isListView = true; // 목록 보기 상태 (true: 리스트, false: 그리드)
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

  // 정렬 옵션 선택 버튼 (PopupMenuButton 사용)
  Widget _buildSortMenu() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          // 정렬 옵션 표시 + 팝업 메뉴
          PopupMenuButton<String>(
            color: Colors.white,
            child: Row(
              children: [
                Text(
                  _sortOption,
                  style: const TextStyle(
                    color: Color(0xFF222222),
                    fontSize: 14,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Icon(Icons.keyboard_arrow_down, color: Color(0xFF222222)),
              ],
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
          const Spacer(),

          // 리스트/그리드 뷰 전환 버튼
          IconButton(
            icon: Icon(_isListView ? Icons.view_list : Icons.calendar_month),
            onPressed: () {
              setState(() {
                _isListView = !_isListView;
              });
            },
          ),
        ],
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
          // 정렬 옵션과 보기 방식 전환 버튼
          _buildSortMenu(),
          // 구분선
          const Divider(height: 1, color: Color(0xFFEFEFEF)),
          // 타임라인 뷰 또는 그리드 뷰
          Expanded(
            child: _isListView
                ? TimelineView()
                : CalendarView(), // <-- 새로 만든 CalendarView 위젯
          ),
        ],
      ),
    );
  }
}