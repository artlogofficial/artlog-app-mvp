import 'package:flutter/material.dart';

class ExRegisterCard extends StatelessWidget {
  final String title;
  final String? hintText;
  final Widget? trailing;
  final VoidCallback? onTap;

  const ExRegisterCard({
    Key? key,
    required this.title,
    this.hintText,
    this.trailing,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 328,
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF222222),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: double.infinity,
              height: 52,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: ShapeDecoration(
                color: Color(0xFFF7F7F7),
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Color(0xFFEFEFEF)),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    hintText ?? "",
                    style: const TextStyle(
                      color: Color(0xFF222222),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  if (trailing != null) trailing!,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}