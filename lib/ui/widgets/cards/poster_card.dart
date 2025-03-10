import 'package:flutter/material.dart';

class PosterCard extends StatelessWidget {
  final int recordCount; // 기록 개수 (0~5)

  const PosterCard({Key? key, required this.recordCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
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
          // 타이틀
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text(
                    "포스터 컬렉션",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "$recordCount",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue.shade600,
                    ),
                  ),
                ],
              ),
              const Icon(Icons.chevron_right, color: Colors.black),
            ],
          ),
          const SizedBox(height: 12),

          // 포스터 이미지 + 진행도 표시
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  "assets/images/poster_$recordCount.png", // 기록 개수에 맞는 포스터 표시
                  width: 64,
                  height: 64,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 진행도 텍스트
                    const Row(
                      children: [
                        Icon(Icons.track_changes, size: 16, color: Colors.red),
                        SizedBox(width: 4),
                        Text(
                          "포스터 진행도",
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),

                    // 진행도 바
                    Stack(
                      children: [
                        Container(
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: recordCount / 5, // 진행도 비율
                          child: Container(
                            height: 8,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),

                    // 진행 개수
                    Text(
                      "$recordCount/5",
                      style: const TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // 진행 상태 메시지
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              _getStatusMessage(recordCount),
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  // 기록 개수에 따라 다른 메시지 반환
  String _getStatusMessage(int count) {
    switch (count) {
      case 0:
        return "🖌 기록으로 포스터를 채워요";
      case 1:
        return "🤲 시작을 응원해요!";
      case 2:
        return "🎨 포스터가 점점 완성되는중...";
      case 3:
        return "💖 포스터가 절반이상 채워졌어요!";
      case 4:
        return "🔥 한 번 더 기록하면 끝...!";
      case 5:
        return "🎉 축하해요! 포스터 완성!!";
      default:
        return "";
    }
  }
}
