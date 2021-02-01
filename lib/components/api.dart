import 'package:Que/components/store.dart';
import 'package:Que/components/store_notifier.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

getStore(StoreNotifier storeNotifier) async {
  QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection('stores').get();

  List<Store> _storeList = [];

  snapshot.docs.forEach((document) {
    Store store = Store.fromMap(document.data());
    _storeList.add(store);
  });

  storeNotifier.storeList = _storeList;
}
