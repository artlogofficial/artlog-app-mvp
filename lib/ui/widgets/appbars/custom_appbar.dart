import 'package:artlog_app_mvp/ui/widgets/common/logo_widget.dart';
import 'package:flutter/material.dart';

enum AppBarType { main, sub, subWithBtn }

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final AppBarType type;
  final bool showBackButton;
  final VoidCallback? onBack;
  final Widget? trailing;
  final String? buttonText; // subWithBtn에서 사용할 버튼 텍스트
  final VoidCallback? onButtonPressed; // 버튼 클릭 이벤트

  const CustomAppBar({
    Key? key,
    required this.title,
    required this.type,
    this.showBackButton = false,
    this.onBack,
    this.trailing,
    this.buttonText,
    this.onButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: type == AppBarType.main
          ? const LogoWidget(size: 36) // 메인 상태에서는 로고 사용
          : Text(title, style: const TextStyle(color: Colors.black)),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: onBack ?? () => Navigator.pop(context),
            )
          : null,
      actions: [
        if (type == AppBarType.subWithBtn && buttonText != null) // subWithBtn에서 버튼 추가
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: TextButton(
              onPressed: onButtonPressed,
              child: Text(
                buttonText!,
                style: const TextStyle(
                  color: Color(0xFF0770E8),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        if (trailing != null) trailing!,
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}