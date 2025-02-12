import 'package:flutter/material.dart';
import 'package:artlog_app_mvp/ui/widgets/common/page_title.dart';
import 'package:artlog_app_mvp/ui/widgets/icons/icon_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:artlog_app_mvp/ui/widgets/appbars/custom_appbar.dart';
import 'package:artlog_app_mvp/ui/widgets/textfields/search_filed.dart'; 
import 'package:artlog_app_mvp/ui/widgets/buttons/outlined_button.dart';
import 'package:artlog_app_mvp/ui/pages/ex_register/ex_register_page.dart'; 

class ExSearchPage extends StatefulWidget {
  @override
  _ExSearchPageState createState() => _ExSearchPageState();
}

class _ExSearchPageState extends State<ExSearchPage> {
  TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> searchResults = [];

  /// 전시 검색 함수
  void searchExhibitions(String query) async {
    if (query.isEmpty) {
      setState(() {
        searchResults = [];
      });
      return;
    }

    String queryLower = query.toLowerCase();

    // Firestore에서 갤러리 데이터 가져오기
    QuerySnapshot gallerySnapshot =
        await FirebaseFirestore.instance.collection('galleries').get();

    List<String> matchingGalleryIds = [];
    Map<String, String> galleryMap = {};

    for (var doc in gallerySnapshot.docs) {
      Map<String, dynamic> galleryData = doc.data() as Map<String, dynamic>;
      String galleryId = galleryData['id'];
      String galleryName = galleryData['name'];

      galleryMap[galleryId] = galleryName;

      if (galleryName.toLowerCase().contains(queryLower)) {
        matchingGalleryIds.add(galleryId);
      }
    }

    // Firestore에서 진행 중인 전시 가져오기
    QuerySnapshot exhibitionSnapshot = await FirebaseFirestore.instance
        .collection('exhibitions')
        .where("status", isEqualTo: "ongoing")
        .get();

    List<Map<String, dynamic>> filteredResults = [];

    for (var doc in exhibitionSnapshot.docs) {
      Map<String, dynamic> exhibitionData = doc.data() as Map<String, dynamic>;
      String title = exhibitionData['title'].toLowerCase();
      String artist = exhibitionData['artist'].toLowerCase();
      String galleryId = exhibitionData['gallery_id'];

      // 검색어가 전시 제목, 작가명, 갤러리명에 포함되어 있는지 확인
      bool matchesQuery = title.contains(queryLower) ||
          artist.contains(queryLower) ||
          galleryMap[galleryId]?.toLowerCase().contains(queryLower) == true ||
          matchingGalleryIds.contains(galleryId);

      if (matchesQuery) {
        String galleryName = galleryMap[galleryId] ?? "알 수 없음";

        filteredResults.add({
          'title': exhibitionData['title'],
          'artist': exhibitionData['artist'],
          'gallery_name': galleryName,
          'end_date': exhibitionData['end_date'],
          'poster_thumb_url': exhibitionData['poster_thumb_url'],
        });
      }
    }

    setState(() {
      searchResults = filteredResults;
    });
  }

  /// 검색 결과가 없을 때 보여줄 UI
  Widget _buildNoResultsUI() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(color: Color(0xFFF2F2F2)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppIcons.alert(size: 80, color: Colors.grey),
          const SizedBox(height: 16),

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

          // 버튼 클릭 시 ExRegisterPage로 이동
          OutlinedButtonWidget(
            text: '전시정보 등록',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ExRegisterPage()),
              );
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
        type: AppBarType.sub,
        showBackButton: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 328, child: PageTitle(title: "어떤 전시를 보셨나요?")),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 328,
                child: SearchField(controller: _searchController),
              ),
            ),
            Expanded(
              child: searchResults.isEmpty
                  ? _buildNoResultsUI()
                  : ListView.builder(
                      itemCount: searchResults.length,
                      itemBuilder: (context, index) {
                        var data = searchResults[index];
                        return ListTile(
                          leading: Image.network(
                            data['poster_thumb_url'],
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
                              Text(data['artist'], style: TextStyle(color: Colors.grey)),
                              Text(data['gallery_name'], style: TextStyle(color: Colors.grey)),
                              Text("~ ${data['end_date']}", style: TextStyle(color: Colors.grey)),
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