import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart'; // 날짜 포맷을 위한 패키지

class DatePickerBottomSheet {
  static void show(
    BuildContext context,
    DateTime? initialStartDate,
    DateTime? initialEndDate,
    Function(DateTime, DateTime) onDateSelected,
  ) {
    DateTime? selectedStartDate = initialStartDate;
    DateTime? selectedEndDate = initialEndDate;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white, // bottom sheet 배경색 설정
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)), // 상단 둥근 모서리 적용
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom, // 키보드 영역 고려
              ),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.55, // 반응형 높이 적용
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 선택된 날짜 표시 (없을 경우 기본 텍스트 출력)
                    Text(
                      selectedStartDate != null && selectedEndDate != null
                          ? "${DateFormat('yyyy.MM.dd').format(selectedStartDate!)} - ${DateFormat('yyyy.MM.dd').format(selectedEndDate!)}"
                          : "기간을 선택하세요",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // 날짜 선택 위젯
                    Expanded(
                      child: SfDateRangePicker(
                        selectionMode: DateRangePickerSelectionMode.range, // 범위 선택 모드
                        initialSelectedRange: selectedStartDate != null && selectedEndDate != null
                            ? PickerDateRange(selectedStartDate, selectedEndDate) // 기존 선택 값 유지
                            : null,

                        // 선택된 날짜 스타일
                        selectionColor: const Color(0xFF00E068), // 선택한 날짜 동그라미 색
                        rangeSelectionColor: const Color(0xFFA8F0C0), // 선택된 날짜 사이 배경색
                        startRangeSelectionColor: const Color(0xFF00E068), // 시작일 색상
                        endRangeSelectionColor: const Color(0xFF00E068), // 종료일 색상

                        onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                          if (args.value is PickerDateRange) {
                            setState(() {
                              selectedStartDate = args.value.startDate;
                              selectedEndDate = args.value.endDate;
                            });
                          }
                        },
                      ),
                    ),

                    const SizedBox(height: 16),
                    
                    // 확인 버튼
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00E068), // 버튼 색상
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12), // 둥근 모서리
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        onPressed: () {
                          if (selectedStartDate != null && selectedEndDate != null) {
                            onDateSelected(selectedStartDate!, selectedEndDate!);
                          }
                          Navigator.pop(context); // bottom sheet 닫기
                        },
                        child: const Text(
                          "확인",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
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