import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:artlog_app_mvp/ui/widgets/cards/record_card.dart';
import 'package:artlog_app_mvp/ui/widgets/common/record_badge.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({Key? key}) : super(key: key);

  @override
  _CalendarViewState createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  bool _isInitialized = false;

  // 날짜별 기록 데이터 (예제)
  final Map<DateTime, List<Map<String, dynamic>>> records = {
    DateTime(2025, 2, 6): [
      {
        'type': RecordBadgeType.now,
        'title': 'Fish & Chips',
        'description': '바다에서 유영하는 느낌을 받았다. 오늘의 멋은 완성되었다.',
        'rating': 5,
        'imageUrl': 'https://picsum.photos/id/237/200/300',
      },
    ],
    DateTime(2025, 2, 4): [
      {
        'type': RecordBadgeType.look,
        'title': '인간, 물질 그리고 변형',
        'description': '심해 속 바다에서 내가 유영하는 듯한 느낌을 받았다.',
        'rating': 5,
        'imageUrl': 'https://picsum.photos/id/238/200/300',
      },
    ],
  };

  @override
  void initState() {
    super.initState();
    _initializeLocale();
  }

  Future<void> _initializeLocale() async {
    await initializeDateFormatting('ko_KR', null);
    setState(() {
      _isInitialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return Container(
      decoration: const BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 1), // 배경색 변경 (흰색)
      ),
      child: Column(
        children: [
          // 달력 UI
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            calendarFormat: CalendarFormat.month,
            locale: 'ko_KR', // 한국어 요일 표시

            // 헤더 스타일 (2025년 2월)
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextFormatter: (date, locale) =>
                  DateFormat('yyyy년 M월', 'ko_KR').format(date),
              titleTextStyle: const TextStyle(
                fontFamily: 'Pretendard', 
                fontWeight: FontWeight.w600,
                fontSize: 18,
                height: 1.0, 
                letterSpacing: 0,
                color: Colors.black,
              ),
              leftChevronIcon:
                  const Icon(Icons.chevron_left, color: Colors.grey),
              rightChevronIcon:
                  const Icon(Icons.chevron_right, color: Colors.grey),
            ),

            // 달력 스타일 수정 (선택되지 않은 날짜 UI 변경 없음)
            calendarStyle: CalendarStyle(
              tablePadding: const EdgeInsets.symmetric(horizontal: 16),
              outsideDaysVisible: false, 
              cellMargin: const EdgeInsets.all(6), 
              todayDecoration: const BoxDecoration(
                color: Colors.transparent, 
                shape: BoxShape.circle,
              ),
              todayTextStyle: const TextStyle(
                color: Color.fromRGBO(8, 112, 232, 1), // 오늘 날짜 텍스트 색상
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),

              // 선택된 날짜 색상 변경
              selectedDecoration: const BoxDecoration(
                color: Color.fromRGBO(8, 112, 232, 1), 
                shape: BoxShape.circle,
              ),
              selectedTextStyle: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            // 요일 스타일 수정
            daysOfWeekStyle: const DaysOfWeekStyle(
              weekdayStyle: TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
              weekendStyle: TextStyle(
                fontSize: 14,
                color: Colors.black, 
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          const SizedBox(height: 16),

          // 선택된 날짜의 기록들 (기록이 없으면 빈 메시지 표시)
          Expanded(
            child: records[_selectedDay]?.isNotEmpty ?? false
                ? ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: records[_selectedDay]!.length,
                    itemBuilder: (context, index) {
                      final record = records[_selectedDay]![index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: RecordCard(
                          type: record['type'],
                          title: record['title'],
                          description: record['description'],
                          imageUrl: record['imageUrl'],
                          rating: record['rating'],
                        ),
                      );
                    },
                  )
                : const Center(
                    child: Text(
                      "선택한 날짜에 기록이 없습니다.",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}