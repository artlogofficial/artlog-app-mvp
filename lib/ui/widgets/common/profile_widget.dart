import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String? imageUrl;
  final bool isEditable;
  final VoidCallback? onEdit;

  const ProfileAvatar({
    Key? key,
    this.imageUrl,
    this.isEditable = false,
    this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: 36,
          backgroundColor: Colors.grey[300],
          backgroundImage: imageUrl != null
              ? NetworkImage(imageUrl!)
              : null, // 이미지가 없으면 기본 아이콘 표시
          child: imageUrl == null
              ? const Icon(Icons.account_circle, size: 72, color: Colors.grey)
              : null,
        ),
        if (isEditable)
          GestureDetector(
            onTap: onEdit,
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 2,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: const Icon(Icons.camera_alt, size: 16, color: Colors.black),
            ),
          ),
      ],
    );
  }
}
