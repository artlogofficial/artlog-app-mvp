import 'package:flutter/material.dart';

class DeleteDialog extends StatelessWidget {
  final VoidCallback onDelete;

  const DeleteDialog({Key? key, required this.onDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      backgroundColor: Colors.white,
      child: Container(
        width: 315,
        padding: const EdgeInsets.fromLTRB(24, 40, 24, 24), // 내부 패딩 설정
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // 컨텐츠 크기에 맞게 조정
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 다이얼로그 제목
            const Text(
              '진짜 삭제해도 돼요?',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 18,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),

            // 다이얼로그 설명
            const Text(
              '삭제하면 되돌릴 수 없어요!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF5B5B5B),
                fontSize: 16,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w400,
                height: 1.50,
              ),
            ),
            const SizedBox(height: 24),

            // 버튼 영역
            Row(
              children: [
                // 취소 버튼
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: TextButton.styleFrom(
                      minimumSize: const Size(0, 44), // 최소 높이 설정 (오버플로우 방지)
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(color: Color(0xFFD8D8D8)),
                      ),
                    ),
                    child: const Text(
                      '취소',
                      style: TextStyle(
                        color: Color(0xFF222222),
                        fontSize: 16,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),

                // 삭제 버튼
                Expanded(
                  child: TextButton(
                    onPressed: onDelete,
                    style: TextButton.styleFrom(
                      minimumSize: const Size(0, 44), // 최소 높이 설정
                      backgroundColor: const Color(0xFFF74F59),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      '삭제',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}