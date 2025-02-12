import 'package:flutter/material.dart';

class ContainedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;

  const ContainedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = const Color(0xFF00E068),
    this.textColor = const Color(0xFF222222),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox( // SizedBox로 버튼 크기 고정
      width: 328,
      height: 52,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: EdgeInsets.zero, 
        ),
        onPressed: onPressed,
        child: Center( // 텍스트를 중앙 정렬
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF222222),
              fontSize: 18,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w600,
              height: 1.33,
              letterSpacing: -0.2,
            ),
          ),
        ),
      ),
    );
  }
}