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
        crossAxisAlignment: CrossAxisAlignment.center, // 중앙 정렬
        children: [
          // 제목 + 선택 텍스트 중앙 정렬
          Row(
            mainAxisAlignment: MainAxisAlignment.center, // 중앙 정렬
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
                  alignment: Alignment.center, // 텍스트 필드 세로 중앙 정렬
                  child: TextField(
                    controller: controller,
                    textAlignVertical: TextAlignVertical.center, // 세로 중앙 정렬
                    style: const TextStyle(
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      height: 1.5, 
                      letterSpacing: 0,
                      color: Color(0xFF222222),
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
                      isDense: true, // 패딩 줄이기
                      contentPadding: EdgeInsets.zero, // 내부 패딩 제거 (세로 정렬 유지)
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
                      mainAxisAlignment: MainAxisAlignment.start, // 왼쪽 정렬 유지
                      children: [
                        if (leadingIcon != null) ...[
                          leadingIcon!,
                          const SizedBox(width: 8), // 아이콘과 텍스트 간격 조정
                        ],
                        Expanded(
                          child: Text(
                            hintText ?? "",
                            textAlign: TextAlign.start, // 중앙 정렬 방지 (왼쪽 배치)
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