import 'package:flutter/widgets.dart';

const String loadingIndicatorTitle = '^';

class HomeViewModel extends ChangeNotifier {
  static const int itemRequestThreshold = 15;

  int _currentPage = 0;
  List<String> _items;

  List<String> get items => _items;

  HomeViewModel() {
    _items = List<String>.generate(15, (index) => 'Title #$index');
  }

  void handleItemCreated(int index) async {
    var itemPosition = index + 1;
    var requestMoreData =
        itemPosition % itemRequestThreshold == 0 && itemPosition != 0;
    var pageToRequest = itemPosition ~/ itemRequestThreshold;

    if (requestMoreData && pageToRequest > _currentPage) {
      _currentPage = pageToRequest;
      _showLoadingIndicator();

      await Future.delayed(Duration(seconds: 3));

      final newlyFetchedItems = List.generate(
          15, (index) => 'Title page: $_currentPage item: $index');

      _items.addAll(newlyFetchedItems);
      _removeLoadingIndicator();
//      notifyListeners();
    }
  }

  _showLoadingIndicator() {
    _items.add(loadingIndicatorTitle);
    notifyListeners();
  }

  _removeLoadingIndicator() {
    _items.remove(loadingIndicatorTitle);
    notifyListeners();
  }
}
