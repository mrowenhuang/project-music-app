import 'package:cloud_firestore/cloud_firestore.dart';

class Cont {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future addData(
    String title,
    String? url,
    String poster,
    String artist,
  ) async {
    CollectionReference music = FirebaseFirestore.instance.collection('music');

    music
        .add({"artist": artist, "title": title, "poster": poster, 'url': url})
        .then((value) {
          print('user added');
        })
        .onError((error, stackTrace) {
          print(error);
        });
  }
}
