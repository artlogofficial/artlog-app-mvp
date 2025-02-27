import 'package:artlog_app_mvp/ui/widgets/common/record_badge.dart';
import 'package:artlog_app_mvp/ui/widgets/cards/record_card.dart'; // 수정된 RecordCard
import 'package:flutter/material.dart';

class TimelineView extends StatefulWidget {
  @override
  _TimelineViewState createState() => _TimelineViewState();
}

class _TimelineViewState extends State<TimelineView> {
  // 임시 기록 데이터 - 날짜별로 그룹화
  final Map<String, List<Map<String, dynamic>>> groupedRecords = {
    '2025 JAN 10': [
      {
        'type': RecordBadgeType.now,
        'title': 'Fish & Chips',
        'description': '마치 심해 속 바다에서 내가 유영하고 있는 듯한 느낌을 받는다. 고요하고 선명한 구조의 아름다움을 본 오늘의 멋은 완성되었다.',
        'rating': 5,
        'imageUrl': 'https://picsum.photos/id/237/200/300',
      },
    ],
    '2025 JAN 9': [
      {
        'type': RecordBadgeType.now,
        'title': 'Fish & Chips',
        'description': '마치 심해 속 바다에서 내가 유영하고 있는 듯한 느낌을 받는다. 고요하고 선명한 구조의 아름다움을 본 오늘의 멋은 완성되었다.',
        'rating': 5,
        'imageUrl': 'https://picsum.photos/id/237/200/300',
      },
    ],
    '2025 JAN 8': [
      {
        'type': RecordBadgeType.look,
        'title': '인간, 물질 그리고 변형',
        'description': '마치 심해 속 바다에서 내가 유영하고 있는 듯한 느낌을 받는다. 고요하고 선명한 구조의 아름다움을 본 오늘의 멋은 완성되었다.',
        'rating': 5,
        'imageUrl': 'https://picsum.photos/id/237/200/300',
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    // 날짜 키를 리스트로 변환하여 순서대로 처리
    final dateKeys = groupedRecords.keys.toList();

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: dateKeys.length,
      itemBuilder: (context, dateIndex) {
        final date = dateKeys[dateIndex];
        final records = groupedRecords[date]!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 날짜 표시
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 8),
              child: _buildDateHeader(date),
            ),
            // 해당 날짜의 기록들을 RecordCard 위젯으로 표시
            ...records.map((record) {
              return _buildRecordCard(record);
            }).toList(),

            // 마지막 날짜가 아니면 구분선 또는 간격 추가
            if (dateIndex < dateKeys.length - 1)
              SizedBox(height: 16),
          ],
        );
      },
    );
  }

  // 날짜 헤더 위젯
  Widget _buildDateHeader(String date) {
    final parts = date.split(' ');
    final year = parts[0];
    final month = parts[1];
    final day = parts[2];

    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              year,
              style: TextStyle(
                color: Color(0xFF5B5B5B),
                fontSize: 12,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              month,
              style: TextStyle(
                color: Color(0xFF5B5B5B),
                fontSize: 12,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              day,
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 14,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // 수정된 RecordCard만 단순 반환
  Widget _buildRecordCard(Map<String, dynamic> record) {
    return RecordCard(
      type: record['type'],
      title: record['title'],
      description: record['description'],
      imageUrl: record['imageUrl'],
      rating: record['rating'],
    );
  }
}