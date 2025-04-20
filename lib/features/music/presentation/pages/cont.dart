import 'package:cloud_firestore/cloud_firestore.dart';

class Cont {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future addData(
    String title,
    String? data,
    String poster,
    String artist,
  ) async {
    CollectionReference music = FirebaseFirestore.instance.collection('musics');

    await music
        .add({
          "_id": DateTime.now().toIso8601String(),
          "artist": artist,
          "title": title,
          "poster": poster,
          '_data': data,
        })
        .then((value) {
          print('user added');
        })
        .onError((error, stackTrace) {
          print(error);
        });
  }
}
