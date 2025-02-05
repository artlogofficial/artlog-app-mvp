import 'package:flutter/material.dart';

class RatingWidget extends StatelessWidget {
  final int rating; // 1~5까지의 별점
  final double starSize; // 별 크기
  final Color filledColor; // 채워진 별 색상
  final Color emptyColor; // 빈 별 색상

  const RatingWidget({
    Key? key,
    required this.rating,
    this.starSize = 13.0,
    this.filledColor = const Color(0xFFFFBC22),
    this.emptyColor = const Color(0xFFE0E0E0),
  })  : assert(rating >= 1 && rating <= 5, "Rating must be between 1 and 5."),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          Icons.star,
          size: starSize,
          color: index < rating ? filledColor : emptyColor,
        );
      }),
    );
  }
}