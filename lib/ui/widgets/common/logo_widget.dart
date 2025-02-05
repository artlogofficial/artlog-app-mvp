import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  final double size;

  const LogoWidget({Key? key, this.size = 70.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size * (133.91 / 70), // 비율 유지
      height: size,
      child: Stack(
        children: [
          Positioned(
            left: size * (66.18 / 70),
            top: size * (23.12 / 70),
            child: Transform(
              transform: Matrix4.identity()..rotateZ(-0.26),
              child: _buildText('L'),
            ),
          ),
          Positioned(
            left: 0,
            top: size * (29.42 / 70),
            child: _buildText('ART'),
          ),
          Positioned(
            left: size * (87.25 / 70),
            top: size * (10.14 / 70),
            child: _buildText('O'),
          ),
          Positioned(
            left: size * (109.57 / 70),
            top: 0,
            child: _buildText('G'),
          ),
        ],
      ),
    );
  }

  Widget _buildText(String letter) {
    return Text(
      letter,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Color(0xFF141414),
        fontSize: 48.70,
        fontFamily: 'DungGeunMo',
        fontWeight: FontWeight.w400,
        height: 0.83,
        letterSpacing: -0.34,
      ),
    );
  }
}