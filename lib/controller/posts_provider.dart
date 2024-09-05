import 'package:flutter/material.dart';
import 'package:zoftcares/models/posts_model.dart';
import 'package:zoftcares/repository/posts_repo/posts_repo.dart';

abstract class DisposableProvider with ChangeNotifier {
  void disposeValues();
}

class PostsProvider extends DisposableProvider {
  List<Datum> _posts = [];
  int _pageIndex = 0;
  bool _isLoadingMore = false;
  bool _hasMore = true;
  String? error;

  List<Datum> get posts => _posts;
  bool get isLoadingMore => _isLoadingMore;
  bool get hasMore => _hasMore;

  Future<void> fetchPosts() async {
    if (_isLoadingMore || !_hasMore) return;
    _isLoadingMore = true;
    notifyListeners();

    try {
      final fetchedPosts = await PostsRepo().getPosts(pageIndex: _pageIndex);
      if (fetchedPosts.nextPage != null && fetchedPosts.hasMore != null) {
        if (fetchedPosts.data != null && fetchedPosts.data!.isNotEmpty) {
          _posts.addAll(fetchedPosts.data!);
          _pageIndex = fetchedPosts.nextPage!;
          if (fetchedPosts.hasMore! && fetchedPosts.nextPage != null) {
            _hasMore = true;
          } else {
            _hasMore = false;
          }
        }
        notifyListeners();
      } else {
        _hasMore = false;
      }
    } catch (e) {
      error = e.toString();
    } finally {
      _isLoadingMore = false;
      notifyListeners();
    }
  }

  @override
  void disposeValues() {
    _posts = [];
    _pageIndex = 0;
    _isLoadingMore = false;
    _hasMore = true;
    error = null;
  }
}
