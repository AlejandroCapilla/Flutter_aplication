import 'package:flutter/widgets.dart';

class FlagsProvider with ChangeNotifier {
  bool _updatePosts = false;
  getUpdatePosts() => _updatePosts;
  setupdatePosts() {
    this._updatePosts = !this._updatePosts;
    notifyListeners();
  }
}
