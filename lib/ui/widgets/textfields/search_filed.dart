import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  final TextEditingController controller; // 사용자 입력 관리 컨트롤러
  final String hintText; // 페이지마다 다른 힌트 텍스트 적용 가능

  const SearchField({
    Key? key,
    required this.controller,
    this.hintText = "전시명, 작가명, 갤러리명 검색", // 기본값 설정
  }) : super(key: key);

  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  bool isTyping = false; // 사용자가 입력 여부

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged); // 텍스트 변경 감지
  }

  void _onTextChanged() {
    setState(() {
      isTyping = widget.controller.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 328,
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(44),
        border: Border.all(
          color: const Color(0xFFD8D8D8),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.search,
            color: Color.fromRGBO(138, 138, 138, 1.0), // 돋보기 아이콘 색상
          ),
          const SizedBox(width: 5.5),
          Expanded(
            child: TextField(
              controller: widget.controller,
              cursorColor: const Color.fromRGBO(8, 112, 233, 1.0),
              decoration: InputDecoration(
                hintText: isTyping ? "" : widget.hintText, // 동적 hintText 적용
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 9),
              ),
              style: TextStyle(
                color: isTyping ? const Color(0xFF222222) : const Color(0xFF898989),
                fontSize: 16,
              ),
            ),
          ),
          if (isTyping)
            GestureDetector(
              onTap: () {
                widget.controller.clear();
                setState(() {
                  isTyping = false;
                });
              },
              child: const Icon(Icons.cancel, color: Colors.grey),
            ),
        ],
      ),
    );
  }
}