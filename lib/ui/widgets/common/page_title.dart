import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {
  final String title; // 동적으로 변경 가능

  const PageTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontFamily: 'Pretendard',
          fontWeight: FontWeight.w600,
          height: 1.4,
          letterSpacing: -0.06,
        ),
      ),
    );
  }
}