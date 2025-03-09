import 'package:flutter/material.dart';

class LogCardWidget extends StatelessWidget {
  final int totalLogs;
  final int nowLogs;
  final int lookLogs;
  final int deepLogs;
  final int thisMonthLogs;

  const LogCardWidget({
    Key? key,
    required this.totalLogs,
    required this.nowLogs,
    required this.lookLogs,
    required this.deepLogs,
    required this.thisMonthLogs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 12),
          _buildLogButtons(),
        ],
      ),
    );
  }

  // 헤더 (아트로그 기록 + 개수 + 이번달 횟수)
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Text(
              '아트로그 기록 ',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF222222),
              ),
            ),
            Text(
              totalLogs.toString(),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF0770E8),
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: const Color(0xFFFFEBF4),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            '이번달 $thisMonthLogs회',
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: Color(0xFFFF52A5),
            ),
          ),
        ),
      ],
    );
  }

  // 로그 버튼 (NOW, LOOK, DEEP)
  Widget _buildLogButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildLogButton(
          title: 'NOW',
          count: nowLogs,
          color: const Color(0xFF1084FE),
          backgroundColor: const Color(0x331F8CFE),
          isLocked: false,
        ),
        _buildLogButton(
          title: 'LOOK',
          count: lookLogs,
          color: const Color(0xFF898989),
          backgroundColor: const Color(0xFFEFEFEF),
          isLocked: true,
        ),
        _buildLogButton(
          title: 'DEEP',
          count: deepLogs,
          color: const Color(0xFF898989),
          backgroundColor: const Color(0xFFEFEFEF),
          isLocked: true,
        ),
      ],
    );
  }

  // 개별 버튼 UI
  Widget _buildLogButton({
    required String title,
    required int count,
    required Color color,
    required Color backgroundColor,
    required bool isLocked,
  }) {
    return Expanded(
      child: Container(
        height: 56,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
            isLocked
                ? const Icon(Icons.lock, size: 16, color: Color(0xFFB5B5B5))
                : Text(
                    count.toString(),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: color,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}