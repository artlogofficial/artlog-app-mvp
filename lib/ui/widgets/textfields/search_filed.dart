import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  final TextEditingController controller; // 사용자 입력 관리 컨트롤러 
  
  const SearchField({Key? key, required this.controller}) : super(key: key);

  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  bool isFocused = false; // 포커스 여부
  bool isTyping = false; // 사용자가 입력 여부

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged); // 텍스트 변경 감지
  }

  void _onFocusChange(bool hasFocus) {
    setState(() {
      isFocused = hasFocus;
    });
  }

  void _onTextChanged() {
    setState(() {
      isTyping = widget.controller.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: _onFocusChange, // 포커스 상태 변경 감지 
      child: Container(
        width: 328,
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: isFocused ? Colors.white : Color(0xFFF7F7F7), // 포커스 여부에 따른 배경색 변경
          borderRadius: BorderRadius.circular(44),
          border: Border.all(
            color: isFocused ? Color(0xFF0070E8) : Color(0xFFD8D8D8), // 포커스 여부에 따른 테두리 색상 변경
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Icon(Icons.search, color: isFocused ? Colors.black : Colors.grey), // 검색 아이콘 색상 변경
            ),
            Expanded(
              child: TextField(
                controller: widget.controller,
                decoration: InputDecoration(
                  hintText: isTyping ? "" : "전시명, 작가명, 갤러리명 검색",
                  border: InputBorder.none,
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
      ),
    );
  }
}