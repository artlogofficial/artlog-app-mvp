import 'package:flutter/material.dart';
import 'package:artlog_app_mvp/ui/widgets/appbars/custom_appbar.dart';

class NowCreatePage extends StatefulWidget {
  @override
  _NowCreatePageState createState() => _NowCreatePageState();
}

class _NowCreatePageState extends State<NowCreatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "NOW 기록",
        type: AppBarType.sub,
        showBackButton: true,
      ),
      body: Center(
        child: Text(
          "전시 감상 기록 작성 페이지",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}