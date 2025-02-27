import 'package:artlog_app_mvp/ui/widgets/cards/record_card.dart';
import 'package:flutter/material.dart';

class TimelineView extends StatefulWidget {
  @override
  _TimelineViewState createState() => _TimelineViewState();
}

class _TimelineViewState extends State<TimelineView> {
  // 예시 기록 목록
  final List<Map<String, String>> records = [
    {
      'title': 'Fish & Chips',
      'description': '마치 심해 속 바다에서 내가 유영하고 있는 듯한 느낌을 받는다.',
      'imageUrl': 'https://via.placeholder.com/80',
      'rating': '4',
    },
    {
      'title': 'Art Exhibition 2',
      'description': '이 전시는 다양한 예술적 감각을 자극한다.',
      'imageUrl': 'https://via.placeholder.com/80',
      'rating': '5',
    },
    // 더 많은 기록을 여기에 추가할 수 있음
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("타임라인"),
      ),
      body: Column(
        children: [
          // 타임라인 리스트
          Expanded(
            child: ListView.builder(
              itemCount: records.length, // 기록의 개수만큼 반복
              itemBuilder: (context, index) {
                return RecordCard(
                  title: records[index]['title']!,
                  description: records[index]['description']!,
                  imageUrl: records[index]['imageUrl']!,
                  rating: int.parse(records[index]['rating']!),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}