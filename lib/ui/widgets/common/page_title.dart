import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {
  final String title; // 변경 가능
  final TextAlign textAlign; // 추가: 텍스트 정렬 설정

  const PageTitle({
    Key? key,
    required this.title,
    this.textAlign = TextAlign.left, // 기본값: 왼쪽 정렬
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: Text(
        title,
        textAlign: textAlign, // 적용: 텍스트 정렬 옵션
        style: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontFamily: 'Pretendard',
          fontWeight: FontWeight.w600,
          height: 1.40,
          letterSpacing: -0.06,
        ),
      ),
    );
  }
}