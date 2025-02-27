import 'package:flutter/material.dart';
import 'package:artlog_app_mvp/ui/widgets/common/record_badge.dart';
import 'package:artlog_app_mvp/ui/widgets/common/rating_widget.dart';

class RecordCard extends StatelessWidget {
  final RecordBadgeType type; // 뱃지 타입 (NOW, LOOK, DEEP)
  final String title;
  final String description;
  final String imageUrl;
  final int rating;

  const RecordCard({
    Key? key,
    required this.type,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // Card 대신 Container 사용, elevation 제거
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        // 필요하다면 경계선 or 배경색 등 추가
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 이미지
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imageUrl,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),

          // 텍스트 + 배지/별점
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 배지 + 별점 Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RecordBadge(type: type), // 뱃지
                    RatingWidget(
                      initialRating: rating,
                      starSize: 16,
                      starSpacing: 2,
                      onRatingChanged: (newRating) {
                        // 현재는 로직 없이 print만
                        print('별점이 $newRating로 변경됨');
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // 제목
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),

                // 설명
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF5B5B5B),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}