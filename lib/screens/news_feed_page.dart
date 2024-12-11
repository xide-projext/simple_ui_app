import 'package:flutter/material.dart';
import '../extensions/string_extension.dart'; // 확장 메서드 import
import 'news_category_page.dart';

class NewsFeedPage extends StatelessWidget {
  final List<String> categories = [
    'world',
    'politics',
    'technology',
    'culture',
    'economy',
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('News Feed'),
          bottom: TabBar(
            isScrollable: true,
            tabs: categories
                .map((category) => Tab(text: category.capitalize())) // 확장 메서드 호출
                .toList(),
          ),
        ),
        body: TabBarView(
          children: categories
              .map((category) => NewsCategoryPage(category: category))
              .toList(),
        ),
      ),
    );
  }
}

