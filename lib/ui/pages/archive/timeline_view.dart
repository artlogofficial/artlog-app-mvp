import 'package:flutter/material.dart';
import 'package:artlog_app_mvp/ui/widgets/common/record_badge.dart';
import 'package:artlog_app_mvp/ui/widgets/cards/record_card.dart';

class TimelineView extends StatefulWidget {
  const TimelineView({Key? key}) : super(key: key);

  @override
  _TimelineViewState createState() => _TimelineViewState();
}

class _TimelineViewState extends State<TimelineView> {
  // 날짜별로 그룹화된 임시 기록 데이터
  final Map<String, List<Map<String, dynamic>>> groupedRecords = {
    '2025 JAN 10': [
      {
        'type': RecordBadgeType.now,
        'title': 'Fish & Chips',
        'description':
            '마치 심해 속 바다에서 내가 유영하고 있는 듯한 느낌을 받는다. 고요하고 선명한 구조의 아름다움을 본 오늘의 멋은 완성되었다.',
        'rating': 5,
        'imageUrl': 'https://picsum.photos/id/237/200/300',
      },
    ],
    '2025 JAN 9': [
      {
        'type': RecordBadgeType.now,
        'title': 'Fish & Chips',
        'description':
            '마치 심해 속 바다에서 내가 유영하고 있는 듯한 느낌을 받는다. 고요하고 선명한 구조의 아름다움을 본 오늘의 멋은 완성되었다.',
        'rating': 5,
        'imageUrl': 'https://picsum.photos/id/237/200/300',
      },
    ],
    '2025 JAN 8': [
      {
        'type': RecordBadgeType.look,
        'title': '인간, 물질 그리고 변형',
        'description':
            '마치 심해 속 바다에서 내가 유영하고 있는 듯한 느낌을 받는다. 고요하고 선명한 구조의 아름다움을 본 오늘의 멋은 완성되었다.',
        'rating': 5,
        'imageUrl': 'https://picsum.photos/id/237/200/300',
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    // 날짜 키를 추출하여 리스트로 변환
    final dateKeys = groupedRecords.keys.toList();

    // ListView.builder → 세로 스크롤 가능, 오버플로우 방지
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 450), // 최대 너비 설정
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          itemCount: dateKeys.length,
          itemBuilder: (context, dateIndex) {
            final date = dateKeys[dateIndex];        // 예: "2025 JAN 10"
            final records = groupedRecords[date]!;   // 해당 날짜의 기록들

            // 예: "2025 JAN 10" → ["2025", "JAN", "10"]
            final parts = date.split(' ');
            final year = parts[0];
            final month = parts[1];
            final day = parts[2];

            // 날짜별로 여러 RecordCard를 표시
            return Column(
              children: [
                ...records.map((record) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline, // 날짜와 RecordCard를 같은 높이로 정렬
                      textBaseline: TextBaseline.alphabetic, // 텍스트 기준선 맞추기
                      children: [
                        // (A) 날짜 텍스트 (왼쪽)
                        SizedBox(
                          width: 40,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                year, // 예: "2025"
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Color(0xFF222222),
                                  fontSize: 11,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w500,
                                  height: 1.2,
                                ),
                              ),
                              Text(
                                month, // 예: "JAN"
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontFamily: 'DungGeunMo',
                                  fontWeight: FontWeight.w400,
                                  height: 1.2,
                                  letterSpacing: -0.06,
                                ),
                              ),
                              Text(
                                day, // 예: "10"
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Color(0xFF222222),
                                  fontSize: 18,
                                  fontFamily: 'DungGeunMo',
                                  fontWeight: FontWeight.w400,
                                  height: 1.2,
                                ),
                              ),
                              const SizedBox(height: 4),
                              // 점 추가
                              Container(
                                width: 4,
                                height: 4,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF222222),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),

                        // (B) RecordCard (오른쪽)
                        Expanded(
                          child: RecordCard(
                            type: record['type'],
                            title: record['title'],
                            description: record['description'],
                            imageUrl: record['imageUrl'],
                            rating: record['rating'],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            );
          },
        ),
      ),
    );
  }
}