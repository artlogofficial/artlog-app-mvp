import 'package:flutter/material.dart';

enum RecordBadgeType { deep, look, now }

class RecordBadge extends StatelessWidget {
  final RecordBadgeType type;

  const RecordBadge({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 상태별 스타일 매핑
    final Map<RecordBadgeType, Map<String, dynamic>> styles = {
      RecordBadgeType.deep: {
        "label": "DEEP",
        "backgroundColor": Color(0x190770E8),
        "textColor": Color(0xFF0770E8),
        "width": 36.0,
      },
      RecordBadgeType.look: {
        "label": "LOOK",
        "backgroundColor": Color(0x1900E068),
        "textColor": Color(0xFF019D4A),
        "width": 38.0,
      },
      RecordBadgeType.now: {
        "label": "NOW",
        "backgroundColor": Color(0x19FF459E),
        "textColor": Color(0xFFFF459E),
        "width": 35.0,
      },
    };

    return Container(
      width: styles[type]?["width"],
      height: 20,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: styles[type]?["backgroundColor"],
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            styles[type]?["label"],
            style: TextStyle(
              color: styles[type]?["textColor"],
              fontSize: 11,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}