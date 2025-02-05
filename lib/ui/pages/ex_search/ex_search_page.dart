import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ExSearchPage extends StatefulWidget {
  @override
  _ExSearchPageState createState() => _ExSearchPageState();
}

class _ExSearchPageState extends State<ExSearchPage> {
  TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> searchResults = []; // ✅ 전시 + 갤러리 이름 포함된 리스트

  void searchExhibitions(String query) async {
    if (query.isEmpty) {
      setState(() {
        searchResults = [];
      });
      return;
    }

    String queryLower = query.toLowerCase(); // 검색어 소문자로 변환

    // ✅ 갤러리 정보에서 검색어 포함된 갤러리 찾기
    QuerySnapshot gallerySnapshot =
        await FirebaseFirestore.instance.collection('galleries').get();

    List<String> matchingGalleryIds = [];
    Map<String, String> galleryMap = {}; // {gallery_id: gallery_name} 저장

    for (var doc in gallerySnapshot.docs) {
      Map<String, dynamic> galleryData = doc.data() as Map<String, dynamic>;
      String galleryId = galleryData['id'];
      String galleryName = galleryData['name'];

      galleryMap[galleryId] = galleryName; // ✅ 갤러리 ID → 이름 매핑 저장

      if (galleryName.toLowerCase().contains(queryLower)) {
        matchingGalleryIds.add(galleryId); // ✅ 검색어가 갤러리명에 포함된 경우 ID 저장
      }
    }

    // ✅ Firestore에서 진행 중인 전시만 가져오기
    QuerySnapshot exhibitionSnapshot = await FirebaseFirestore.instance
        .collection('exhibitions')
        .where("status", isEqualTo: "ongoing") // 진행 중인 전시만 가져오기
        .get();

    List<Map<String, dynamic>> filteredResults = [];

    for (var doc in exhibitionSnapshot.docs) {
      Map<String, dynamic> exhibitionData = doc.data() as Map<String, dynamic>;
      String title = exhibitionData['title'].toLowerCase();
      String artist = exhibitionData['artist'].toLowerCase();
      String galleryId = exhibitionData['gallery_id'];

      // 🔹 부분 검색 가능하도록 설정
      bool matchesQuery = title.contains(queryLower) ||
          artist.contains(queryLower) ||
          galleryMap[galleryId]?.toLowerCase().contains(queryLower) ==
              true || // ✅ 갤러리 이름 검색 추가
          matchingGalleryIds.contains(galleryId); // ✅ 갤러리명 검색 결과 ID가 포함되면 매칭

      if (matchesQuery) {
        String galleryName = galleryMap[galleryId] ?? "알 수 없음"; // ✅ 갤러리 이름 가져오기

        // 검색 결과에 전시 정보 + 갤러리 이름 포함
        filteredResults.add({
          'title': exhibitionData['title'],
          'artist': exhibitionData['artist'],
          'gallery_name': galleryName, // ✅ 갤러리 ID → 갤러리 이름 변환
          'end_date': exhibitionData['end_date'],
          'poster_thumb_url': exhibitionData['poster_thumb_url'],
        });
      }
    }

    setState(() {
      searchResults = filteredResults;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("NOW 기록")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "전시명, 작가명, 갤러리명 검색",
                prefixIcon: Icon(Icons.search),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onChanged: searchExhibitions,
            ),
          ),
          Expanded(
            child: searchResults.isEmpty
                ? Center(child: Text("검색 결과가 없습니다."))
                : ListView.builder(
                    itemCount: searchResults.length,
                    itemBuilder: (context, index) {
                      var data = searchResults[index];
                      return ListTile(
                        leading: Image.network(data['poster_thumb_url'],
                            width: 50, height: 50, fit: BoxFit.cover),
                        title: Text(data['title'],
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(data['artist'],
                                style: TextStyle(color: Colors.grey)),
                            Text(data['gallery_name'],
                                style: TextStyle(
                                    color: Colors.grey)), // ✅ 갤러리 이름 표시
                            Text("~ ${data['end_date']}",
                                style:
                                    TextStyle(color: Colors.grey)), // ✅ 종료일만 표시
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
