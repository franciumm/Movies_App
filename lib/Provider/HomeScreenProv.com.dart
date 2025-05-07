import 'package:flutter/widgets.dart';

class HomeProv extends ChangeNotifier {
  /// Changing this will force the scroll subtree to rebuild.
  int reloadKey = 0;

  void addWishList() {
    notifyListeners();
  }

  /// Called once on startup
  Future<void> fetchInitialData() async {
    await Future.wait([
      loadTopSection(),
      loadNewReleases(),
      loadRecommended(),
    ]);
  }

  /// Called by pull-to-refresh
  Future<void> reloadHomeData() async {
    reloadKey++;
    await fetchInitialData();
    notifyListeners();
  }

  Future<void> loadTopSection() async {
    // your top-section fetch
  }

  Future<void> loadNewReleases() async {
    // your new-releases fetch
  }

  Future<void> loadRecommended() async {
    // your recommended fetch
  }
}