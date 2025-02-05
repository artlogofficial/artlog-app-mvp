import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UploadJsonService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Firestore에 exhibition.json을 업로드 (전시 데이터)
  Future<void> uploadExhibitionsToFirestore() async {
    try {
      // JSON 파일 불러오기
      String jsonString =
          await rootBundle.loadString('assets/datas/exhibition.json');
      List<dynamic> jsonData = json.decode(jsonString);

      // Firestore 컬렉션 참조
      CollectionReference collectionRef = _firestore.collection('exhibitions');

      for (var item in jsonData) {
        // ✅ Map<String, dynamic>으로 변환해서 저장
        Map<String, dynamic> exhibitionData = Map<String, dynamic>.from(item);

        // Firestore에 같은 title이 있는지 확인
        QuerySnapshot existingData = await collectionRef
            .where('title', isEqualTo: exhibitionData['title'])
            .get();

        if (existingData.docs.isEmpty) {
          // 종료일(end_date) 기준으로 status 계산
          String status = getStatus(exhibitionData['end_date']);

          // Firestore에 추가 (자동 생성된 문서 ID 사용)
          await collectionRef.add({
            ...exhibitionData,
            "status": status,
            "created_at": FieldValue.serverTimestamp(),
          });

          print(
              "✅ Firestore에 추가된 전시: ${exhibitionData['title']} (status: $status)");
        }
      }

      print("🔥 Firestore JSON 전시 데이터 업로드 완료!");
    } catch (e) {
      print("❌ Firestore 전시 데이터 업로드 오류: $e");
    }
  }

  /// ✅ Firestore에 gallery.json을 업로드 (갤러리 데이터 추가)
  Future<void> uploadGalleriesToFirestore() async {
    try {
      // ✅ gallery.json 파일 불러오기
      String jsonString =
          await rootBundle.loadString('assets/datas/gallery.json'); // ✅ 수정됨
      List<dynamic> jsonData = json.decode(jsonString);

      // Firestore 컬렉션 참조
      CollectionReference collectionRef =
          _firestore.collection('galleries'); // ✅ 수정됨

      for (var item in jsonData) {
        // ✅ Map<String, dynamic>으로 변환해서 저장
        Map<String, dynamic> galleryData = Map<String, dynamic>.from(item);

        // Firestore에 같은 id가 있는지 확인 (갤러리 ID는 중복되면 안됨)
        DocumentSnapshot existingGallery =
            await collectionRef.doc(galleryData['id']).get();

        if (!existingGallery.exists) {
          // Firestore에 추가 (갤러리 ID를 문서 ID로 사용)
          await collectionRef.doc(galleryData['id']).set(galleryData); // ✅ 수정됨

          print("✅ Firestore에 추가된 갤러리: ${galleryData['name']}");
        } else {
          print("⚠️ 이미 존재하는 갤러리: ${galleryData['name']}");
        }
      }

      print("🔥 Firestore JSON 갤러리 데이터 업로드 완료!");
    } catch (e) {
      print("❌ Firestore 갤러리 데이터 업로드 오류: $e");
    }
  }

  /// 종료일 기준으로 status 설정하는 함수
  String getStatus(String endDateString) {
    DateTime endDate = DateTime.parse(endDateString);
    DateTime now = DateTime.now();

    return (now.isAfter(endDate)) ? "ended" : "ongoing";
  }
}
