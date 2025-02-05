import 'package:flutter/material.dart';

class DateRangePickerWidget extends StatefulWidget {
  final VoidCallback onTap;
  final String? startDate;
  final String? endDate;

  const DateRangePickerWidget({
    Key? key,
    required this.onTap,
    this.startDate,
    this.endDate,
  }) : super(key: key);

  @override
  _DateRangePickerWidgetState createState() => _DateRangePickerWidgetState();
}

class _DateRangePickerWidgetState extends State<DateRangePickerWidget> {
  bool get isFilled => widget.startDate != null && widget.endDate != null;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: 296,
        height: 52,
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isFilled ? Colors.black : Color(0xFFEFEFEF), // 선택된 경우 검정 테두리
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                widget.startDate ?? "시작일자", // `enabled` 상태일 때 기본 텍스트
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isFilled ? Colors.black : Color(0xFF898989), // 선택된 경우 글씨 색 진하게
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Text("~"),
            Expanded(
              child: Text(
                widget.endDate ?? "종료일자", // `enabled` 상태일 때 기본 텍스트
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isFilled ? Colors.black : Color(0xFF898989), // 선택된 경우 글씨 색 진하게
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}