import 'package:flutter/material.dart';
import 'package:artlog_app_mvp/ui/widgets/appbars/custom_appbar.dart';

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
}