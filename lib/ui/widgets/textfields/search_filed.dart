import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  final TextEditingController controller; // 사용자 입력 관리 컨트롤러 
  
  const SearchField({Key? key, required this.controller}) : super(key: key);

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
        color: Colors.white, // 항상 흰색 배경 유지
        borderRadius: BorderRadius.circular(44),
        border: Border.all(
          color: Color(0xFFD8D8D8), 
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Icon(
              Icons.search,
              color: Color.fromRGBO(138, 138, 138, 1.0), 
            ),
          ),
          Expanded(
            child: TextField(
              controller: widget.controller,
              cursorColor: Color.fromRGBO(8, 112, 233, 1.0),
              decoration: InputDecoration(
                hintText: isTyping ? "" : "전시명, 작가명, 갤러리명 검색",
                border: InputBorder.none,
                isDense: true, 
                contentPadding: EdgeInsets.symmetric(vertical: 10.0),
              ),
              style: TextStyle(
                color: isTyping ? Color(0xFF222222) : Color(0xFF898989), // 입력 여부에 따른 글씨 색상 변경
                fontSize: 16,
              ),
            ),
          ),
          if (isTyping) // 입력 중일 때만 X 버튼 표시
            GestureDetector(
              onTap: () {
                widget.controller.clear();
                setState(() {
                  isTyping = false;
                });
              },
              child: Icon(Icons.cancel, color: Colors.grey),
            ),
        ],
      ),
    );
  }
}