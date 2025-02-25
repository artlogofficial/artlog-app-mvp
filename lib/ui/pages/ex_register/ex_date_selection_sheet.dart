import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

class DatePickerBottomSheet {
  static void show(
    BuildContext context, {
    DateTime? initialDate, // 하루 선택 모드일 때 사용
    DateTime? initialStartDate,
    DateTime? initialEndDate,
    required Function(DateTime, DateTime?) onDateSelected,
    bool isSingleSelection = false, // 하루만 선택할 수 있는지 여부
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        DateTime? selectedDate = initialDate;
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
                    // 선택된 날짜 표시
                    Text(
                      isSingleSelection
                          ? (selectedDate != null
                              ? DateFormat('yyyy.MM.dd').format(selectedDate!)
                              : "날짜를 선택하세요")
                          : (selectedStart != null && selectedEnd != null
                              ? "${DateFormat('yyyy.MM.dd').format(selectedStart!)} - ${DateFormat('yyyy.MM.dd').format(selectedEnd!)}"
                              : "날짜를 선택하세요"),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    Expanded(
                      child: SfDateRangePicker(
                        selectionMode: isSingleSelection
                            ? DateRangePickerSelectionMode.single
                            : DateRangePickerSelectionMode.range,
                        initialSelectedDate: isSingleSelection ? selectedDate : null,
                        initialSelectedRange: !isSingleSelection && selectedStart != null && selectedEnd != null
                            ? PickerDateRange(selectedStart, selectedEnd)
                            : null,
                        backgroundColor: Colors.white,
                        monthViewSettings: const DateRangePickerMonthViewSettings(
                          firstDayOfWeek: 1,
                        ),
                        selectionColor: const Color(0xFF00E068),
                        startRangeSelectionColor: const Color(0xFF00E068),
                        endRangeSelectionColor: const Color(0xFF00E068),
                        rangeSelectionColor: const Color(0xFF99F0B0),
                        headerHeight: 50,
                        headerStyle: const DateRangePickerHeaderStyle(
                          backgroundColor: Colors.white,
                          textAlign: TextAlign.center,
                          textStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        navigationDirection: DateRangePickerNavigationDirection.horizontal,
                        monthFormat: 'M월',
                        onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                          setState(() {
                            if (isSingleSelection) {
                              selectedDate = args.value as DateTime;
                            } else if (args.value is PickerDateRange) {
                              selectedStart = args.value.startDate;
                              selectedEnd = args.value.endDate;
                            }
                          });
                        },
                      ),
                    ),

                    const SizedBox(height: 16),

                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00E068),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          if (isSingleSelection && selectedDate != null) {
                            onDateSelected(selectedDate!, null);
                            Navigator.pop(context);
                          } else if (!isSingleSelection && selectedStart != null && selectedEnd != null) {
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