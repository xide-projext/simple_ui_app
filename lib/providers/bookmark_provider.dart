import 'package:flutter/foundation.dart';

class BookmarkProvider extends ChangeNotifier {
  final List<dynamic> _bookmarks = [];

  List<dynamic> get bookmarks => _bookmarks;

  void addBookmark(dynamic article) {
    if (!_bookmarks.contains(article)) {
      _bookmarks.add(article);
      notifyListeners();
    }
  }

  void removeBookmark(dynamic article) {
    _bookmarks.remove(article);
    notifyListeners();
  }
}
