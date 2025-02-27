import 'package:flutter/material.dart';
import 'package:artlog_app_mvp/ui/widgets/common/record_badge.dart';
import 'package:artlog_app_mvp/ui/widgets/common/rating_widget.dart';

class RecordCard extends StatelessWidget {
  final RecordBadgeType type; 
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
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // (1) 상단 Row: 배지 + 별점 + 점 세 개 아이콘
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  RecordBadge(type: type), // 뱃지
                  const SizedBox(width: 8),
                  RatingWidget(
                    initialRating: rating,
                    starSize: 16,
                    starSpacing: 2,
                    onRatingChanged: (newRating) {
                      print('별점이 $newRating로 변경됨');
                    },
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.more_horiz),
                onPressed: () {
                  // TODO: 점 3개 눌렀을 때 실행될 로직
                  print('점 3개 아이콘 클릭됨');
                },
              ),
            ],
          ),

          // (2) 하단 Row: 이미지 + (제목, 설명) 텍스트
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 이미지
              Container(
                width: 60,
                height: 86,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 12),

              // 텍스트 영역 (제목, 코멘트)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 제목
                    Text(
                      title,
                      style: const TextStyle(
                        color: Color(0xFF222222),
                        fontSize: 16,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                        height: 1.50,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),

                    // 코멘트
                    SizedBox(
                      width: 173,
                      height: 62,
                      child: Text(
                        description,
                        style: const TextStyle(
                          color: Color(0xFF5B5B5B),
                          fontSize: 14,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w400,
                          height: 1.50,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}