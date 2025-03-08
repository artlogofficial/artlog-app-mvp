import 'package:flutter/material.dart';

enum RecordBadgeType { deep, look, now }

class RecordBadge extends StatelessWidget {
  final RecordBadgeType type;

  const RecordBadge({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<RecordBadgeType, Map<String, dynamic>> styles = {
      RecordBadgeType.deep: {
        "label": "DEEP",
        "backgroundColor": Color(0xE8E9F7FF),  
        "textColor": Color(0xFF0341D1), 
      },
      RecordBadgeType.look: {
        "label": "LOOK",
        "backgroundColor": Color(0xD1D3F0F1),  
        "textColor": Color(0xFF00C967), 
        "width": 38.0,
      },
      RecordBadgeType.now: {
        "label": "NOW",
        "backgroundColor": Color(0xFFFFF0F4),
        "textColor": Color(0xFFFF52A5),  
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
              letterSpacing: 0,  // No letter-spacing
            ),
          ),
        ],
      ),
    );
  }
}