import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  final double size;

  const LogoWidget({
    Key? key, 
    this.size = 70.0, // 기본 높이값 70으로 설정
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 로고의 원래 가로/세로 비율 유지
    final double width = size * (133.91 / 70);

    return SizedBox(
      width: width,
      height: size,
      child: Stack(
        children: [
          // L 글자
          Positioned(
            left: size * (66.18 / 70),
            top: size * (23.12 / 70),
            child: Transform(
              transform: Matrix4.identity()..rotateZ(-0.26),
              child: _buildLetter('L'),
            ),
          ),
          // ART 글자
          Positioned(
            left: 0,
            top: size * (29.42 / 70),
            child: _buildLetter('ART'),
          ),
          // O 글자
          Positioned(
            left: size * (87.25 / 70),
            top: size * (10.14 / 70),
            child: _buildLetter('O'),
          ),
          // G 글자
          Positioned(
            left: size * (109.57 / 70),
            top: 0,
            child: _buildLetter('G'),
          ),
        ],
      ),
    );
  }

  // 공통 텍스트 스타일을 적용하는 헬퍼 메소드
  Widget _buildLetter(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: const Color(0xFF141414),
        fontSize: size * (48.70 / 70), // 폰트 크기를 size에 비례하게 조정
        fontFamily: 'DungGeunMo',
        fontWeight: FontWeight.w400,
        height: 0.83,
        letterSpacing: -0.34,
      ),
    );
  }
}