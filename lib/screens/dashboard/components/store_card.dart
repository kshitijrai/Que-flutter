import 'package:Que/components/store.dart';
import 'package:Que/components/store_notifier.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StoreCard extends StatefulWidget {
  @override
  _StoreCardState createState() => _StoreCardState();
}

class _StoreCardState extends State<StoreCard> {
  @override
  void initState() {
    StoreNotifier storeNotifier =
        Provider.of<StoreNotifier>(context, listen: false);
    getStore(storeNotifier);
    super.initState();
  }

  CollectionReference storeRef =
      FirebaseFirestore.instance.collection('stores');
  getStore(StoreNotifier storeNotifier) async {
    QuerySnapshot snapshot = await storeRef.get();

    print("Got it!");

    List<Store> _storeList = [];

    snapshot.docs.forEach((document) {
      Store store = Store.fromMap(document.data());
      // print('uploaded id successfully: ${store.id}');

      _storeList.add(store);
    });

    storeNotifier.storeList = _storeList;
  }

  updateStore(bool ij, int cl, dynamic il) async {
    QuerySnapshot snapshot = await storeRef.get();
    User user = FirebaseAuth.instance.currentUser;
    DocumentReference stores = storeRef.doc(user.uid);

    snapshot.docs.forEach((document) {
      Store store;

      store.inline = ij;
      store.currentLine = cl;
      print('updated');

      return stores.update(store.toMap());
    });
  }

  @override
  Widget build(BuildContext context) {
    StoreNotifier storeNotifier = Provider.of<StoreNotifier>(context);
    User user = FirebaseAuth.instance.currentUser;
    String currentUserId = user.uid;
    handleLine() async {
      Map lines;
      CollectionReference storeRef =
          FirebaseFirestore.instance.collection('stores');
      DocumentReference stores =
          storeRef.doc(storeNotifier.storeList[index].storeName);

      Store store;
      bool _isJoined = lines[currentUserId] == false;
      if (_isJoined) {
        storeRef.doc(stores.id).update({
          // 'lines.$currentUserId': true,
          'isJoined': true,
          'currentLine': store.currentLine + 1,
        });
        setState(() {
          store.currentLine -= 1;
          _isJoined = true;
          // lines[currentUserId] = true;
        });
      } else if (!_isJoined) {
        storeRef.doc(user.uid).update({
          // 'lines.$currentUserId': false,
          'isJoined': false,

          'currentLine': store.currentLine - 1,
        });
        setState(() {
          store.currentLine -= 1;
          _isJoined = false;
          lines[currentUserId] = false;
        });
      }
    }

    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        storeNotifier.storeList[index].isJoined =
            (storeNotifier.storeList[index].lines[currentUserId] == true);
        return Card(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(0),
                child: ListTile(
                  title: Text(storeNotifier.storeList[index].storeName),
                  subtitle: Text(storeNotifier.storeList[index].location),
                  trailing: FlatButton(
                      color: (storeNotifier.storeList[index].isJoined
                          ? Colors.red[400]
                          : Theme.of(context).primaryColor),
                      textColor: Colors.white,
                      padding: EdgeInsets.all(8),
                      splashColor: Theme.of(context).accentColor,
                      child: Text(
                          storeNotifier.storeList[index].isJoined
                              ? "Leave Line"
                              : "Join Line",
                          style: TextStyle(fontSize: 15)),
                      onPressed: () {
                        setState(
                          () {
                            handleLine();
                            print(storeNotifier.storeList[index].currentLine);
                            print(storeNotifier.storeList[index].isJoined);
                            // updateStore(
                            //   storeNotifier.storeList[index].isJoined,
                            //   storeNotifier.storeList[index].currentLine,
                            //   storeNotifier.storeList[index].inline,
                            // );
                          },
                        );
                      }),
                ),
              ),
              Row(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.fromLTRB(17, 0, 20, 20),
                      child: Row(
                        children: <Widget>[
                          Text(
                            (storeNotifier.storeList[index].currentLine)
                                    .toString() +
                                " shoppers in line",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                            width: 210,
                            child: Text(
                                "Avg. Wait Time: " +
                                    storeNotifier.storeList[index].waitTime
                                        .toString() +
                                    " minutes",
                                textAlign: TextAlign.end),
                          ),
                        ],
                      )),
                ],
              )
            ],
          ),
          color: Colors.grey[5],
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          color: Colors.black,
        );
      },
      itemCount: storeNotifier.storeList.length,
    );
  }
}
