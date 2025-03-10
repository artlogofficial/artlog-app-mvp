import 'package:artlog_app_mvp/ui/widgets/appbars/custom_appbar.dart';
import 'package:artlog_app_mvp/ui/widgets/common/profile_widget.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: '마이 프로필',
        type: AppBarType.settings, // 설정 아이콘이 있는 앱바
        showBackButton: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Center(
            child: ProfileAvatar(
              imageUrl: null, // 기본 프로필 아이콘 사용
              editMode: true, // 편집 모드 활성화 (연필 아이콘 표시)
              onEdit: () {
                print('프로필 편집 클릭됨');
              },
            ),
          ),
        ],
      ),
    );
  }
}
