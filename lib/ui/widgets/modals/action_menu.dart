import 'package:artlog_app_mvp/ui/pages/now/now_edit_page.dart';
import 'package:flutter/material.dart';
import 'package:artlog_app_mvp/ui/widgets/modals/delete_dialog.dart';

class ActionMenu extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final Map<String, dynamic> recordData; // 수정할 데이터 추가

  const ActionMenu({
    Key? key,
    required this.onEdit,
    required this.onDelete,
    required this.recordData, // 파라미터 추가
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

          // 수정하기 버튼
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 24),
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
              Navigator.pop(context); // 모달 닫기
              
              // NowEditPage로 이동하며 데이터 전달
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NowEditPage(recordData: recordData),
                ),
              );
              
              // 추가로 콜백 실행 (필요한 경우)
              onEdit();
            },
          ),

          // 삭제하기 버튼 (삭제 다이얼로그 사용)
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 24),
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
              Navigator.pop(context); // 모달 닫기
              showDialog(
                context: context,
                barrierDismissible: true, // 바깥 클릭 시 닫기
                builder: (context) => DeleteDialog(
                  onDelete: () {
                    Navigator.pop(context); // 다이얼로그 닫기
                    onDelete(); // 삭제 로직 실행
                  },
                ),
              );
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