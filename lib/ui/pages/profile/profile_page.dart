import 'package:artlog_app_mvp/ui/widgets/appbars/custom_appbar.dart';
import 'package:artlog_app_mvp/ui/widgets/cards/poster_card.dart';
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
        children: [
          // 프로필 영역
          Container(
            width: double.infinity,
            height: 174,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ProfileAvatar(
                  imageUrl: null, // 기본 프로필 아이콘 사용
                  editMode: true, // 편집 모드 활성화 (연필 아이콘 표시)
                  onEdit: () {
                    print('프로필 편집 클릭됨');
                  },
                ),
                const SizedBox(height: 16),
                const Description(), // 설명 추가
              ],
            ),
          ),

          // 프로필 영역과 PosterCard 사이 간격 추가
          const SizedBox(height: 24),

          // PosterCard 추가
          const PosterCard(recordCount: 2), // 기록 개수는 동적으로 변경 가능
        ],
      ),
    );
  }
}

class Description extends StatelessWidget {
  const Description({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '아트로거',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        SizedBox(
          width: 296,
          child: Text(
            '전시 감상 기록으로 나를 발견하고 더 깊이 알아가요. 주1회 기록은 꼭 합니다.',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w400,
              height: 1.50,
            ),
          ),
        ),
      ],
    );
  }
}
