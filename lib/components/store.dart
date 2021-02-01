import 'package:firebase_auth/firebase_auth.dart';

class Store {
  String storeName;
  String location;
  String image;
  String id;
  int currentLine;
  dynamic inline;
  int waitTime;
  Map lines;
  bool isJoined;

  String currentUserId;

  Store();
  User user = FirebaseAuth.instance.currentUser;

  Store.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    storeName = data['storeName'];
    location = data['location'];
    image = data['image'];
    // inline = data['inline'];
    isJoined = data['isJoined'];
    lines = data['lines'];
    currentLine = data['currentLine'];
    waitTime = data['waitTime'];
    currentUserId = user.uid;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'storeName': storeName,
      'location': location,
      'image': image,
      'inline': user.uid,
      'isJoined': lines[currentUserId],
      'lines': lines[currentUserId],
      'currentLine': 0,
      'waitTime': waitTime,
    };
  }
}
