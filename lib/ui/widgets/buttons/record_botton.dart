import 'package:flutter/material.dart';

class RecordButton extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const RecordButton({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 328,
        height: 70,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: ShapeDecoration(
          color: Color(0xFFF2F2F2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 34,
                fontFamily: 'DungGeunMo',
                fontWeight: FontWeight.w400,
                letterSpacing: -2.38,
              ),
            ),
            Row(
              children: [
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Color(0xFF222222),
                    fontSize: 14,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(width: 8),
                Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black),
              ],
            ),
          ],
        ),
      ),
    );
  }
}