import 'package:artlog_app_mvp/ui/widgets/common/logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum AppBarType { main, sub, subWithBtn, settings } // 'settings' 타입 추가

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final AppBarType type;
  final bool showBackButton;
  final VoidCallback? onBack;
  final String? buttonText;
  final VoidCallback? onButtonPressed;
  final VoidCallback? onAlarmPressed;
  final VoidCallback? onSettingsPressed;

  const CustomAppBar({
    Key? key,
    required this.title,
    required this.type,
    this.showBackButton = true,
    this.onBack,
    this.buttonText,
    this.onButtonPressed,
    this.onAlarmPressed,
    this.onSettingsPressed, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: _buildLeading(context),
      leadingWidth: type == AppBarType.main ? 120 : 48, // sub일 때 기본 크기 조정
      title: _buildTitle(),
      centerTitle: type != AppBarType.main, // 메인 앱바에서는 가운데 정렬 비활성화
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: _buildActions(),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }

  // AppBar의 왼쪽 영역 (로고 또는 뒤로 가기 버튼)
  Widget? _buildLeading(BuildContext context) {
    if (type == AppBarType.main) {
      return Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: SizedBox(
          width: 120,
          height: kToolbarHeight,
          child: Align(
            alignment: Alignment.centerLeft,
            child: LogoWidget(size: 36),
          ),
        ),
      );
    }

    if (!showBackButton) return null;

    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        onPressed: onBack ?? () => Navigator.pop(context),
      ),
    );
  }

  // AppBar의 타이틀 설정 (메인에서는 숨김)
  Widget _buildTitle() {
    if (type == AppBarType.main) {
      return const SizedBox.shrink();
    }

    return Text(
      title,
      style: const TextStyle(
        color: Colors.black,
        fontFamily: 'Pretendard',
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 1.25,
        letterSpacing: 0,
      ),
    );
  }

  // AppBar의 오른쪽 영역 (알람 아이콘, 설정 아이콘, 추가 버튼 등)
  List<Widget> _buildActions() {
    final List<Widget> actions = [];

    if (type == AppBarType.main) {
      // 메인 앱바 - 알람 아이콘
      actions.add(
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: onAlarmPressed ?? () {},
          ),
        ),
      );
    } else if (type == AppBarType.settings) {
      // 설정 앱바 - 톱니바퀴 아이콘
      actions.add(
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: IconButton(
            icon: const Icon(Icons.settings, color: Colors.black),
            onPressed: onSettingsPressed ?? () {}, 
          ),
        ),
      );
    } else if (type == AppBarType.subWithBtn && buttonText != null) {
      // 🔹 버튼이 있는 서브 앱바
      actions.add(
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: TextButton(
            onPressed: onButtonPressed,
            child: Text(
              buttonText!,
              style: const TextStyle(
                color: Color(0xFF0770E8),
                fontFamily: 'Pretendard',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                height: 1.25,
                letterSpacing: 0,
              ),
            ),
          ),
        ),
      );
    }

    return actions;
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}