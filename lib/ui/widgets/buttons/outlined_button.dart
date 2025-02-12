import 'package:flutter/material.dart';

class OutlinedButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color borderColor;
  final Color textColor;

  const OutlinedButtonWidget({
    Key? key,
    required this.text,
    required this.onPressed,
    this.borderColor = const Color(0xFF222222),
    this.textColor = const Color(0xFF222222),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: 135), // 최소 너비 보장
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20), // 패딩 조정
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          side: BorderSide(width: 1, color: borderColor),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFF222222),
            fontSize: 16,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w600,
            height: 1.25,
          ),
        ),
      ),
    );
  }
}