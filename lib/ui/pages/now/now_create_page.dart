import 'package:flutter/material.dart';
import './now_detail.dart'; // 변경된 파일명 반영

class NowCreatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 생성 모드로 공통 페이지 호출
    return NowDetailPage(
      mode: RecordMode.create,
    );
  }
}