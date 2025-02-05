import 'package:flutter/material.dart';

class AppIcons {
  static const double defaultSize = 24.0; // 기본 아이콘 크기

  // ⚠️ Alert 아이콘
  static Widget alert({double size = defaultSize, Color color = Colors.black}) {
    return Icon(Icons.error_outline, size: size, color: color);
  }

  // 📷 Camera 아이콘
  static Widget camera({double size = defaultSize, Color color = Colors.black}) {
    return Icon(Icons.camera_alt, size: size, color: color);
  }

  // 🔍 Search 아이콘
  static Widget search({double size = defaultSize, Color color = Colors.black}) {
    return Icon(Icons.search, size: size, color: color);
  }

  // 📍 Location 아이콘
  static Widget location({double size = defaultSize, Color color = Colors.black}) {
    return Icon(Icons.location_on, size: size, color: color);
  }

  // ❌ Cancelled (X) 아이콘
  static Widget cancelled({double size = defaultSize, Color color = Colors.black}) {
    return Icon(Icons.cancel, size: size, color: color);
  }

  // ✏️ Modify (Edit) 아이콘
  static Widget modify({double size = defaultSize, Color color = Colors.black}) {
    return Icon(Icons.edit, size: size, color: color);
  }

  // 🗑 Trash (삭제) 아이콘
  static Widget trash({double size = defaultSize, Color color = Colors.black}) {
    return Icon(Icons.delete, size: size, color: color);
  }

  // 🗑 Trash (두 번째 삭제 아이콘 - 모양이 다를 경우 대비)
  static Widget trashOutlined({double size = defaultSize, Color color = Colors.black}) {
    return Icon(Icons.delete_outline, size: size, color: color);
  }

  // 🔔 Alarm (알림) 아이콘
  static Widget alarm({double size = defaultSize, Color color = Colors.black}) {
    return Icon(Icons.notifications, size: size, color: color);
  }

  // ◀ Back (뒤로가기) 아이콘
  static Widget back({double size = defaultSize, Color color = Colors.black}) {
    return Icon(Icons.arrow_back, size: size, color: color);
  }

  // ❌ Close (닫기) 아이콘
  static Widget close({double size = defaultSize, Color color = Colors.black}) {
    return Icon(Icons.close, size: size, color: color);
  }
}