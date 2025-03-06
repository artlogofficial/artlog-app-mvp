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

  // null 허용으로 변경하고 late 키워드 제거
  Map<String, List<Map<String, dynamic>>>? _recordsByDateString;

  @override
  void initState() {
    super.initState();
    _initializeLocale();
    _initializeRecords();
  }

  void _initializeRecords() {
    // 문자열 키를 사용하여 날짜 비교 문제 해결
    _recordsByDateString = {
      _dateToString(DateTime(2025, 3, 10)): [
        {
          'type': RecordBadgeType.now,
          'title': '빛과 공간',
          'description': '전시장에서 빛이 공간을 가르는 순간을 포착했다.',
          'rating': 4,
          'imageUrl': 'https://picsum.photos/id/239/200/300',
        },
      ],
      _dateToString(DateTime(2025, 3, 9)): [
        {
          'type': RecordBadgeType.now,
          'title': '추상과 감성',
          'description': '색과 형태의 조합이 주는 감각적인 표현을 경험했다.',
          'rating': 5,
          'imageUrl': 'https://picsum.photos/id/240/200/300',
        },
      ],
      _dateToString(DateTime(2025, 3, 8)): [
        {
          'type': RecordBadgeType.look,
          'title': '인간, 물질 그리고 변형',
          'description': '물질의 변화를 탐구하는 전시에서 깊은 인상을 받았다.',
          'rating': 5,
          'imageUrl': 'https://picsum.photos/id/241/200/300',
        },
      ],
    };
    
    // 초기화 시 데이터 디버깅
    _recordsByDateString?.forEach((key, value) {
      print('날짜 키: $key, 기록 수: ${value.length}');
    });
  }

  // 날짜를 문자열로 변환 (yyyy-MM-dd 형식)
  String _dateToString(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  // 로컬라이제이션을 초기화하여 날짜 포맷을 올바르게 표시
  Future<void> _initializeLocale() async {
    await initializeDateFormatting('ko_KR', null);
    setState(() {
      _isInitialized = true;
    });
  }

  // 선택된 날짜의 기록 가져오기
  List<Map<String, dynamic>> _getRecordsForSelectedDay() {
    if (_recordsByDateString == null) return [];
    
    final dateString = _dateToString(_selectedDay);
    print('선택된 날짜 키: $dateString');
    return _recordsByDateString![dateString] ?? [];
  }

  // 특정 날짜에 기록이 있는지 확인
  bool _hasRecordsForDay(DateTime day) {
    if (_recordsByDateString == null) return false;
    
    final dateString = _dateToString(day);
    return _recordsByDateString!.containsKey(dateString);
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return Container(
      decoration: const BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 1),
      ),
      child: Column(
        children: [
          // 캘린더 UI
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                // 선택된 날짜 정보 출력
                print('선택한 날짜: ${selectedDay.year}-${selectedDay.month}-${selectedDay.day}');
                
                // 시간 정보를 제거하여 날짜만 저장
                _selectedDay = DateTime(selectedDay.year, selectedDay.month, selectedDay.day);
                _focusedDay = focusedDay;
                
                // 선택 후 기록 정보 확인
                final records = _getRecordsForSelectedDay();
                print('선택된 날짜의 기록 수: ${records.length}');
              });
            },
            calendarFormat: CalendarFormat.month,
            locale: 'ko_KR',

            // 캘린더 헤더 스타일 (예: 2025년 3월)
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
              leftChevronIcon: const Icon(Icons.chevron_left, color: Colors.grey),
              rightChevronIcon: const Icon(Icons.chevron_right, color: Colors.grey),
            ),

            // 캘린더 내부 스타일
            calendarStyle: CalendarStyle(
              tablePadding: const EdgeInsets.symmetric(horizontal: 16),
              outsideDaysVisible: false,
              cellMargin: const EdgeInsets.all(6),
              todayDecoration: const BoxDecoration(
                color: Colors.transparent, // 오늘 날짜의 배경 없음
                shape: BoxShape.circle,
              ),
              todayTextStyle: const TextStyle(
                color: Color.fromRGBO(8, 112, 232, 1), // 오늘 날짜 텍스트 색상
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              selectedDecoration: const BoxDecoration(
                color: Color.fromRGBO(8, 112, 232, 1), // 선택된 날짜 배경색
                shape: BoxShape.circle,
              ),
              selectedTextStyle: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            // 요일 스타일
            daysOfWeekStyle: const DaysOfWeekStyle(
              weekdayStyle: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500),
              weekendStyle: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500),
            ),
            
            // 이벤트 표시 마커
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, date, events) {
                // 간소화된 방식으로 마커 표시
                if (_hasRecordsForDay(date)) {
                  return Positioned(
                    bottom: -2,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        width: 5,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(8, 112, 232, 1),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  );
                }
                return null;
              },
            ),
          ),

          const SizedBox(height: 16),

          // 선택된 날짜의 기록 목록
          Expanded(
            child: _getRecordsForSelectedDay().isNotEmpty
                ? ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _getRecordsForSelectedDay().length,
                    itemBuilder: (context, index) {
                      final record = _getRecordsForSelectedDay()[index];
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