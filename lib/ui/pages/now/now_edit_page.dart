import 'package:flutter/material.dart';
import './now_detail.dart'; // 변경된 파일명 반영

class NowEditPage extends StatelessWidget {
  final Map<String, dynamic> recordData;
  
  const NowEditPage({Key? key, required this.recordData}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    // 수정 모드로 공통 페이지 호출하고 초기 데이터 전달
    return NowDetailPage(
      mode: RecordMode.edit,
      initialData: recordData,
    );
  }
}