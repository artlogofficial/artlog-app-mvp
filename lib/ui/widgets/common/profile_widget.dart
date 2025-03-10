import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String? imageUrl;
  final bool editMode; // true: 연필 아이콘, false: 카메라 아이콘
  final VoidCallback? onEdit;

  const ProfileAvatar({
    Key? key,
    this.imageUrl,
    this.editMode = false, // 기본값은 카메라 아이콘 (등록 모드)
    this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        ClipOval(
          child: imageUrl != null
              ? Image.network(
                  imageUrl!,
                  width: 72,
                  height: 72,
                  fit: BoxFit.cover,
                ) 
              : Image.asset(
                  'assets/images/default_profile.png',
                  width: 72,
                  height: 72,
                  fit: BoxFit.cover,
                ),  // 기본 프로필 이미지
        ),
        GestureDetector(
          onTap: onEdit,
          child: Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(
              editMode ? Icons.edit : Icons.camera_alt, // 편집: 연필, 등록: 카메라
              size: 16,
              color: const Color(0xFFB5B5B5), // 아이콘 색상 변경
            ),
          ),
        ),
      ],
    );
  }
}
