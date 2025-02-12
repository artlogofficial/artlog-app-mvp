import 'package:flutter/material.dart';

class ExRegisterCard extends StatelessWidget {
  final String title;
  final String? hintText;
  final String? optionalHint; // 선택적으로 표시될 작은 텍스트 (ex: "선택")
  final Widget? leadingIcon; // 왼쪽 아이콘 추가
  final VoidCallback? onTap;
  final bool isTextField; // TextField 여부 추가
  final TextEditingController? controller; // TextField 컨트롤러 추가

  const ExRegisterCard({
    Key? key,
    required this.title,
    this.hintText,
    this.optionalHint,
    this.leadingIcon,
    this.onTap,
    this.isTextField = false, // 기본값 false로 설정
    this.controller,
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
          // 제목 + 선택 텍스트 조합
          Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF222222),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (optionalHint != null) ...[
                const SizedBox(width: 8), // 간격 조정
                Text(
                  optionalHint!,
                  style: const TextStyle(
                    color: Color(0xFF9E9E9E),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 16),

          // 입력 필드 또는 버튼 선택
          isTextField
              ? Container(
                  width: double.infinity,
                  height: 52,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: ShapeDecoration(
                    color: Color(0xFFF7F7F7),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 1, color: Color(0xFFEFEFEF)),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: hintText,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 16), // 높이 맞춤
                    ),
                  ),
                )
              : GestureDetector(
                  onTap: onTap,
                  child: Container(
                    width: double.infinity,
                    height: 52,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: ShapeDecoration(
                      color: Color(0xFFF7F7F7),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(width: 1, color: Color(0xFFEFEFEF)),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start, // 왼쪽 정렬
                      children: [
                        if (leadingIcon != null) ...[
                          leadingIcon!,
                          const SizedBox(width: 8), // 아이콘과 텍스트 간격
                        ],
                        Expanded(
                          child: Text(
                            hintText ?? "",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color(0xFF222222),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}