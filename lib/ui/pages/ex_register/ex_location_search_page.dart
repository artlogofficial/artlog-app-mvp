import 'package:artlog_app_mvp/ui/widgets/appbars/custom_appbar.dart';
import 'package:artlog_app_mvp/ui/widgets/textfields/search_filed.dart';
import 'package:flutter/material.dart';

class LocationSearchPage extends StatefulWidget {
  @override
  _LocationSearchPageState createState() => _LocationSearchPageState();
}

class _LocationSearchPageState extends State<LocationSearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<String> searchResults = [];

  void _searchLocation(String query) {
    setState(() {
      searchResults = ["갤러리 현대", "리움 미술관", "국립현대미술관"]
          .where((location) => location.contains(query))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      _searchLocation(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "장소 검색",
        type: AppBarType.sub,
        showBackButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 🔹 SearchField 위젯 적용 (hintText 변경)
            SearchField(
              controller: _searchController,
              hintText: "장소명 검색",
            ),
            const SizedBox(height: 16),

            // 🔹 검색 결과 리스트
            Expanded(
              child: ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(searchResults[index]),
                    onTap: () {
                      Navigator.pop(context, searchResults[index]);
                    },
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