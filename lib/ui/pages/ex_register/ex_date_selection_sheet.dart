import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DatePickerBottomSheet {
  static void show(BuildContext context, DateTime? initialStartDate, DateTime? initialEndDate, Function(DateTime, DateTime) onDateSelected) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, 
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.5, // 반응형 높이 적용
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "전시 기간 선택",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),

                Expanded(
                  child: SfDateRangePicker(
                    selectionMode: DateRangePickerSelectionMode.range,
                    initialSelectedRange: initialStartDate != null && initialEndDate != null
                        ? PickerDateRange(initialStartDate, initialEndDate) // 🟢 기존 선택 값 유지
                        : null,
                    onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                      if (args.value is PickerDateRange) {
                        final DateTime? startDate = args.value.startDate;
                        final DateTime? endDate = args.value.endDate;
                        if (startDate != null && endDate != null) {
                          onDateSelected(startDate, endDate);
                        }
                      }
                    },
                  ),
                ),

                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("확인"),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}