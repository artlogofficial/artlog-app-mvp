import 'package:flutter/material.dart';

class ExRegisterCard extends StatelessWidget {
  final String title;
  final String? hintText;
  final String? optionalHint; // 선택적으로 표시될 작은 텍스트 (ex: "선택")
  final Widget? leadingIcon; // 왼쪽 아이콘 추가
  final VoidCallback? onTap;
  final bool isTextField; // TextField 여부 추가
  final TextEditingController? controller; // TextField 컨트롤러 추가
  final bool hasValue; // 값이 입력되었는지 확인

  const ExRegisterCard({
    Key? key,
    required this.title,
    this.hintText,
    this.optionalHint,
    this.leadingIcon,
    this.onTap,
    this.isTextField = false,
    this.controller,
    this.hasValue = false, // 기본값은 값이 없는 상태
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 제목 + 선택 텍스트 중앙 정렬
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF222222),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (optionalHint != null) ...[
                const SizedBox(width: 8),
                Text(
                  optionalHint!,
                  textAlign: TextAlign.center,
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
                    color: const Color(0xFFF7F7F7),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 1, color: Color(0xFFEFEFEF)),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: TextField(
                    controller: controller,
                    textAlignVertical: TextAlignVertical.center,
                    style: const TextStyle(
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      height: 1.5,
                      letterSpacing: 0,
                      color: Color(0xFF222222), // 항상 검정색 유지
                    ),
                    decoration: InputDecoration(
                      hintText: hintText,
                      hintStyle: const TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        height: 1.5,
                        letterSpacing: 0,
                        color: Color(0xFF8A8A8A), // Placeholder 색상 적용
                      ),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
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
                      color: const Color(0xFFF7F7F7),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(width: 1, color: Color(0xFFEFEFEF)),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if (leadingIcon != null) ...[
                          leadingIcon!,
                          const SizedBox(width: 8),
                        ],
                        Expanded(
                          child: Text(
                            hintText ?? "",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: hasValue
                                  ? const Color(0xFF222222) // 값이 입력되었을 때 검정색
                                  : const Color(0xFF8A8A8A), // 값이 없을 때 placeholder 색상
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