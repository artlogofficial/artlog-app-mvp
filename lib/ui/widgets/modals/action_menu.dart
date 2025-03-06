import 'package:flutter/material.dart';

class ActionMenu extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ActionMenu({
    Key? key,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 230,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          Container(
            width: 40,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 16),

          // 수정하기 버튼 (여백 추가)
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 24), // 좌우 여백 추가
            leading: const Icon(Icons.edit, color: Colors.black),
            title: const Text(
              "수정하기",
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w600,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              onEdit();
            },
          ),

          // 삭제하기 버튼 (여백 추가)
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 24), // 좌우 여백 추가
            leading: const Icon(Icons.delete, color: Colors.red),
            title: const Text(
              "삭제하기",
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w600,
                color: Colors.red,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              onDelete();
            },
          ),

          // 취소 버튼
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(color: Color(0xFFD8D8D8)),
                ),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w600,
                ),
              ),
              child: const Center(child: Text("취소")),
            ),
          ),
        ],
      ),
    );
  }
}