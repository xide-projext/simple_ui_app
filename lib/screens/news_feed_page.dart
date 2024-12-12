import 'package:flutter/material.dart';
import '../extensions/string_extension.dart';
import 'news_category_page.dart';

class NewsFeedPage extends StatelessWidget {
  const NewsFeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> categories = [
      'world',
      'politics',
      'technology',
      'culture',
      'economy',
    ]; // Move the list here to avoid constant expression error.

    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('News Feed'),
          bottom: TabBar(
            isScrollable: true,
            tabs: categories
                .map((category) => Tab(text: category.capitalize())) // Extension method call
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

