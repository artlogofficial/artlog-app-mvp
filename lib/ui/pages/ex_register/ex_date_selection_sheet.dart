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
      backgroundColor: Colors.white,
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
                height: MediaQuery.of(context).size.height * 0.55,
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

                    Expanded(
                      child: SfDateRangePicker(
                        selectionMode: DateRangePickerSelectionMode.range,
                        initialSelectedRange: selectedStart != null && selectedEnd != null
                            ? PickerDateRange(selectedStart, selectedEnd)
                            : null,
                        backgroundColor: Colors.white,
                        monthViewSettings: const DateRangePickerMonthViewSettings(
                          firstDayOfWeek: 1,
                        ),
                        selectionColor: const Color(0xFF00E068),
                        rangeSelectionColor: const Color(0xFF99F0B0),
                        startRangeSelectionColor: const Color(0xFF00E068),
                        endRangeSelectionColor: const Color(0xFF00E068),
                        headerHeight: 50, // 헤더 높이 조정
                        headerStyle: const DateRangePickerHeaderStyle(
                          backgroundColor: Colors.white,
                          textAlign: TextAlign.center, // 텍스트 중앙 정렬
                          textStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        navigationDirection: DateRangePickerNavigationDirection.horizontal,
                        monthFormat: 'M월', 
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

                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6, // 확인 버튼 길이 조정
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
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
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