import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UploadJsonService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Firestore에 JSON 파일을 업로드 (중복 체크 포함) + 종료일 기준으로 status 저장
  Future<void> uploadJsonToFirestore() async {
    try {
      // JSON 파일 불러오기
      String jsonString =
          await rootBundle.loadString('assets/datas/exhibition.json');
      List<dynamic> jsonData = json.decode(jsonString);

      // Firestore 컬렉션 참조
      CollectionReference collectionRef = _firestore.collection('exhibitions');

      for (var item in jsonData) {
        // ✅ Map<String, dynamic>으로 변환해서 저장 (이 부분이 중요!!)
        Map<String, dynamic> exhibitionData = Map<String, dynamic>.from(item);

        // Firestore에 같은 title이 있는지 확인
        QuerySnapshot existingData = await collectionRef
            .where('title', isEqualTo: exhibitionData['title']) // 전시 제목 중복 확인
            .get();

        if (existingData.docs.isEmpty) {
          // 종료일(end_date) 기준으로 status 계산
          String status = getStatus(exhibitionData['end_date']);

          // Firestore에 추가 (자동 생성된 문서 ID 사용)
          await collectionRef.add({
            ...exhibitionData, // 기존 JSON 데이터 포함
            "status": status, // 종료일 기준 status 자동 설정
            "created_at": FieldValue.serverTimestamp(), // 업로드 시간 자동 추가
          });

          print(
              "✅ Firestore에 추가된 전시: ${exhibitionData['title']} (status: $status)");
        }
      }

      print("🔥 Firestore JSON 데이터 업로드 완료!");
    } catch (e) {
      print("❌ Firestore 데이터 업로드 오류: $e");
    }
  }

  /// 종료일 기준으로 status 설정하는 함수
  String getStatus(String endDateString) {
    DateTime endDate =
        DateTime.parse(endDateString); // `end_date`를 DateTime으로 변환
    DateTime now = DateTime.now();

    return (now.isAfter(endDate)) ? "ended" : "ongoing";
  }
}
