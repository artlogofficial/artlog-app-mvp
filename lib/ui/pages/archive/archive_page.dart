import 'package:flutter/material.dart';
import 'package:artlog_app_mvp/ui/widgets/appbars/custom_appbar.dart';
import 'package:artlog_app_mvp/ui/widgets/common/page_title.dart'; // PageTitle 위젯 import

class ArchivePage extends StatefulWidget {
  @override
  _ArchivePageState createState() => _ArchivePageState();
}

class _ArchivePageState extends State<ArchivePage> {
  int _currentIndex = 1; // 아카이브 탭 인덱스

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  // 메인 앱바 적용 (이제 상단에 위치)
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildCustomAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // PageTitle 위젯
          PageTitle(
            title: "나만의 예술취향 아카이브", 
            textAlign: TextAlign.left, 
          ),
          // 여기에 다른 UI 구성 요소들 (예: 기록 리스트, 탭 등)을 추가할 수 있습니다.
        ],
      ),
    );
  }
}