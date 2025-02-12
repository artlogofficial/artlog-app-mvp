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
    return Container(
      width: 360, // 🔹 너비 설정
      height: 60, // 🔹 높이 설정
      alignment: Alignment.centerLeft, // 🔹 텍스트를 항상 왼쪽 정렬
      padding: const EdgeInsets.all(16), // 🔹 padding 설정 (16px)
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
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
        ],
      ),
    );
  }
}