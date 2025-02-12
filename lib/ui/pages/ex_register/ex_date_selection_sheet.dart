import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

class DatePickerBottomSheet {
  static void show(
    BuildContext context,
    DateTime? initialStartDate,
    DateTime? initialEndDate,
    Function(DateTime, DateTime) onDateSelected,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white, // BottomSheet 배경색 설정
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        DateTime? selectedStart = initialStartDate;
        DateTime? selectedEnd = initialEndDate;

        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.55, // 반응형 높이 적용
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 선택된 날짜 표시 (굵게)
                    Text(
                      (selectedStart != null && selectedEnd != null)
                          ? "${DateFormat('yyyy.MM.dd').format(selectedStart!)} - ${DateFormat('yyyy.MM.dd').format(selectedEnd!)}"
                          : "날짜를 선택하세요",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // 날짜 선택기
                    Expanded(
                      child: SfDateRangePicker(
                        selectionMode: DateRangePickerSelectionMode.range,
                        initialSelectedRange: selectedStart != null && selectedEnd != null
                            ? PickerDateRange(selectedStart, selectedEnd)
                            : null,
                        backgroundColor: Colors.white, // 달력 내부 색상 변경
                        monthViewSettings: const DateRangePickerMonthViewSettings(
                          firstDayOfWeek: 1,
                        ),
                        selectionColor: const Color(0xFF00E068), // 선택된 날짜 색상
                        rangeSelectionColor: const Color(0xFF99F0B0), // 선택된 날짜 사이 색상
                        startRangeSelectionColor: const Color(0xFF00E068), // 시작 날짜 색상
                        endRangeSelectionColor: const Color(0xFF00E068), // 종료 날짜 색상
                        headerStyle: const DateRangePickerHeaderStyle(
                          backgroundColor: Colors.white, // 헤더 배경색을 BottomSheet 배경과 동일하게 설정
                          textAlign: TextAlign.center,
                          textStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black, // 텍스트 색상 유지
                          ),
                        ),
                        monthFormat: 'yyyy년 M월', // 년/월 포맷 변경
                        onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                          if (args.value is PickerDateRange) {
                            final DateTime? startDate = args.value.startDate;
                            final DateTime? endDate = args.value.endDate;
                            setState(() {
                              selectedStart = startDate;
                              selectedEnd = endDate;
                            });
                          }
                        },
                      ),
                    ),

                    const SizedBox(height: 16),

                    // 확인 버튼
                    SizedBox(
                                            width: MediaQuery.of(context).size.width * 0.8, // 가로 길이 조정
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00E068),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          if (selectedStart != null && selectedEnd != null) {
                            onDateSelected(selectedStart!, selectedEnd!);
                            Navigator.pop(context);
                          } else {
                            // 날짜 미선택 시 경고 메시지 표시
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("날짜를 선택해주세요."),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }
                        },
                        child: const Text(
                          "확인",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16), // 하단 여백 추가
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}