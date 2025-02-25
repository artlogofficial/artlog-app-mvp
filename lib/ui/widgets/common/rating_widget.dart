import 'package:flutter/material.dart';

class RatingWidget extends StatefulWidget {
  final int initialRating; // 초기 별점 (1~5)
  final double starSize; // 별 크기
  final Color filledColor; // 채워진 별 색상
  final Color emptyColor; // 빈 별 색상
  final Function(int) onRatingChanged; // 별점 변경 콜백

  const RatingWidget({
    Key? key,
    required this.initialRating,
    required this.onRatingChanged,
    this.starSize = 24.0,
    this.filledColor = const Color(0xFFFFBC22),
    this.emptyColor = const Color(0xFFE0E0E0),
  })  : assert(initialRating >= 1 && initialRating <= 5, "Rating must be between 1 and 5."),
        super(key: key);

  @override
  _RatingWidgetState createState() => _RatingWidgetState();
}

class _RatingWidgetState extends State<RatingWidget> {
  late int rating;

  @override
  void initState() {
    super.initState();
    rating = widget.initialRating; // 초기 별점 설정
  }

  void _updateRating(int newRating) {
    setState(() {
      rating = newRating;
    });
    widget.onRatingChanged(newRating); // 별점 변경 콜백 실행
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: () => _updateRating(index + 1), // 터치 시 해당 별점으로 변경
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 200),
            transitionBuilder: (child, animation) => ScaleTransition(scale: animation, child: child),
            child: Icon(
              Icons.star,
              key: ValueKey<int>(index < rating ? 1 : 0), // 별점이 변경될 때마다 애니메이션 적용
              size: widget.starSize,
              color: index < rating ? widget.filledColor : widget.emptyColor,
            ),
          ),
        );
      }),
    );
  }
}