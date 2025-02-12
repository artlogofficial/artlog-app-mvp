import 'package:artlog_app_mvp/ui/widgets/common/page_title.dart';
import 'package:artlog_app_mvp/ui/widgets/icons/icon_widgets.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:artlog_app_mvp/ui/widgets/appbars/custom_appbar.dart';
import 'package:artlog_app_mvp/ui/widgets/textfields/search_filed.dart'; 
import 'package:artlog_app_mvp/ui/widgets/buttons/outlined_button.dart';

class ExSearchPage extends StatefulWidget {
  @override
  _ExSearchPageState createState() => _ExSearchPageState();
}

class _ExSearchPageState extends State<ExSearchPage> {
  TextEditingController _searchController = TextEditingController(); // 검색 입력 필드 컨트롤러
  List<Map<String, dynamic>> searchResults = []; // 검색 결과 리스트

  /// 🔹 전시 검색 함수
  void searchExhibitions(String query) async {
    if (query.isEmpty) {
      setState(() {
        searchResults = [];
      });
      return;
    }

    String queryLower = query.toLowerCase(); // 검색어 소문자로 변환 (대소문자 구분 방지)

    // 🔹 Firestore에서 갤러리 데이터 가져오기
    QuerySnapshot gallerySnapshot =
        await FirebaseFirestore.instance.collection('galleries').get();

    List<String> matchingGalleryIds = [];
    Map<String, String> galleryMap = {}; // {gallery_id: gallery_name} 저장

    for (var doc in gallerySnapshot.docs) {
      Map<String, dynamic> galleryData = doc.data() as Map<String, dynamic>;
      String galleryId = galleryData['id'];
      String galleryName = galleryData['name'];

      galleryMap[galleryId] = galleryName; // 갤러리 ID → 갤러리 이름 매핑 저장

      if (galleryName.toLowerCase().contains(queryLower)) {
        matchingGalleryIds.add(galleryId); // 검색어가 포함된 갤러리 ID 저장
      }
    }

    // 🔹 Firestore에서 진행 중인 전시만 가져오기
    QuerySnapshot exhibitionSnapshot = await FirebaseFirestore.instance
        .collection('exhibitions')
        .where("status", isEqualTo: "ongoing") // 진행 중인 전시만 필터링
        .get();

    List<Map<String, dynamic>> filteredResults = [];

    for (var doc in exhibitionSnapshot.docs) {
      Map<String, dynamic> exhibitionData = doc.data() as Map<String, dynamic>;
      String title = exhibitionData['title'].toLowerCase();
      String artist = exhibitionData['artist'].toLowerCase();
      String galleryId = exhibitionData['gallery_id'];

      // 🔹 검색어가 전시 제목, 작가명, 갤러리명에 포함되어 있는지 확인
      bool matchesQuery = title.contains(queryLower) ||
          artist.contains(queryLower) ||
          galleryMap[galleryId]?.toLowerCase().contains(queryLower) == true ||
          matchingGalleryIds.contains(galleryId); // 검색된 갤러리 ID와 일치 여부 확인

      if (matchesQuery) {
        String galleryName = galleryMap[galleryId] ?? "알 수 없음"; // 갤러리 이름 가져오기

        // 검색 결과에 전시 정보 + 갤러리 이름 포함
        filteredResults.add({
          'title': exhibitionData['title'],
          'artist': exhibitionData['artist'],
          'gallery_name': galleryName, // 갤러리 ID를 갤러리 이름으로 변환
          'end_date': exhibitionData['end_date'],
          'poster_thumb_url': exhibitionData['poster_thumb_url'],
        });
      }
    }

    setState(() {
      searchResults = filteredResults; // UI 업데이트
    });
  }

  /// 🔹 검색 결과가 없을 때 보여줄 UI (중앙 정렬)
  Widget _buildNoResultsUI() {
    return Container(
      width: double.infinity, // 🔹 너비를 화면 전체로 설정
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(color: Color(0xFFF2F2F2)), // 배경 색상 적용
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center, // 🔹 중앙 정렬
        children: [
          AppIcons.alert(size: 80, color: Colors.grey), // 🚨 Alert 아이콘 추가
          const SizedBox(height: 16),

          // 🔹 "검색 결과가 없습니다" 텍스트
          Text(
            '검색 결과가 없습니다.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF191919),
              fontSize: 16,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w400,
              height: 1.50,
            ),
          ),
          const SizedBox(height: 8),

          // 🔹 "찾고 있는 결과가 없다면 직접 등록해 보세요." 안내 텍스트
          Text(
            '찾고 있는 결과가 없다면 직접 등록해 보세요.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF5B5B5B),
              fontSize: 14,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w400,
              height: 1.43,
            ),
          ),
          const SizedBox(height: 16),

          // 🖊 "전시정보 등록" 버튼 (OutlinedButtonWidget 사용)
          OutlinedButtonWidget(
            text: '전시정보 등록',
            onPressed: () {
              // TODO: 전시정보 등록 화면으로 이동하는 기능 추가
            },
            borderColor: Color(0xFF222222),
            textColor: Color(0xFF222222),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "NOW 기록", 
        type: AppBarType.sub, // 서브 앱바 스타일 적용
        showBackButton: true, 
      ),
      body: Center( // 🔹 전체 UI 중앙 정렬
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center, // 🔹 모든 요소 중앙 정렬
          children: [
            const SizedBox(width: 328, child: PageTitle(title: "어떤 전시를 보셨나요?")), // 🔹 제목도 중앙 정렬
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 328, // 🔹 검색바 너비를 고정하여 정렬 문제 해결
                child: SearchField(controller: _searchController),
              ),
            ),
            Expanded(
              child: searchResults.isEmpty
                  ? _buildNoResultsUI() // 🔹 검색 결과 없음 UI 적용
                  : ListView.builder(
                      itemCount: searchResults.length,
                      itemBuilder: (context, index) {
                        var data = searchResults[index];
                        return ListTile(
                          leading: Image.network(
                            data['poster_thumb_url'], // 포스터 이미지 URL
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          title: Text(
                            data['title'],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(data['artist'], style: TextStyle(color: Colors.grey)), // 작가명
                              Text(data['gallery_name'], style: TextStyle(color: Colors.grey)), // 갤러리명
                              Text("~ ${data['end_date']}", style: TextStyle(color: Colors.grey)), // 종료일
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}