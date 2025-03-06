import 'package:artlog_app_mvp/ui/widgets/modals/action_menu.dart';
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
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 상단 Row: 배지 + 별점 + 점 세 개 아이콘
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  RecordBadge(type: type),
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
                  _showActionMenu(context);
                },
              ),
            ],
          ),
          const SizedBox(height: 8),

          // 하단 Row: 이미지 + (제목, 설명) 텍스트
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 60,
                height: 86,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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

  // BottomSheet 호출 메서드
  void _showActionMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      builder: (context) {
        return ActionMenu(
          onEdit: () {
            print("기록 수정 화면으로 이동");
          },
          onDelete: () {
            print("기록이 삭제됨");
          },
        );
      },
    );
  }
}