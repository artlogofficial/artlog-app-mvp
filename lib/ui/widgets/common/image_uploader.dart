import 'package:flutter/material.dart';

class ImageUploadWidget extends StatelessWidget {
  const ImageUploadWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: 향후 기능 추가 가능 (현재는 클릭 시 아무 동작 없음)
      },
      child: Container(
        width: 100,
        height: 144,
        decoration: BoxDecoration(
          color: const Color(0xFFD9D9D9), // 배경 색상
          borderRadius: BorderRadius.circular(4.65),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.camera_alt, size: 24, color: Color(0xFFB5B5B5)),
            const SizedBox(height: 10),
            const Text(
              "사진 추가",
              style: TextStyle(
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w600,
                fontSize: 13,
                height: 1.2,
                color: Color(0xFF9E9E9E),
              ),
            ),
          ],
        ),
      ),
    );
  }
}