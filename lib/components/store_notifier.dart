import 'dart:collection';

import 'package:Que/components/store.dart';
import 'package:flutter/cupertino.dart';

class StoreNotifier with ChangeNotifier {
  List<Store> _storeList = [];
  Store _currentStore;

  UnmodifiableListView<Store> get storeList => UnmodifiableListView(_storeList);

  Store get currentStore => _currentStore;

  set storeList(List<Store> storeList) {
    _storeList = storeList;
    notifyListeners();
  }

  set currentStore(Store store) {
    _currentStore = store;
    notifyListeners();
  }

  addFood(Store store) {
    _storeList.insert(0, store);
    notifyListeners();
  }
}
