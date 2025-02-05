import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;

  const CustomTextField({Key? key, required this.hintText, required this.controller}) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isFocused = false;
  bool isTyping = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
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
      onFocusChange: _onFocusChange,
      child: Container(
        width: 296,
        height: 52,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isFocused || isTyping ? Colors.white : Color(0xFFF7F7F7), // `focused` 또는 `typing` 상태일 때 배경 변경
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isFocused ? Color(0xFF0070E8) : Color(0xFFEFEFEF), // `focused`일 때 파란색 테두리
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: widget.controller,
                decoration: InputDecoration(
                  hintText: isTyping ? "" : widget.hintText, // 입력 중이면 힌트 텍스트 사라짐
                  border: InputBorder.none,
                ),
                style: TextStyle(
                  color: isTyping ? Color(0xFF222222) : Color(0xFF898989), // 입력 중이면 글자색 변경
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
                child: Icon(Icons.cancel, color: Colors.grey),
              ),
          ],
        ),
      ),
    );
  }
}