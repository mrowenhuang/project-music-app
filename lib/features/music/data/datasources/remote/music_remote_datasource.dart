// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_music_app/core/failure/server_failure.dart';
import 'package:flutter_music_app/features/music/data/models/music_models.dart';

abstract class MusicRemoteDatasource {
  Future<List<MusicModels>> getMusic();
}

class MusicRemoteDatasourceImpl implements MusicRemoteDatasource {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<List<MusicModels>> getMusic() async {
    try {
      final CollectionReference coll = firestore.collection('music');
      final response = await coll.get();

      final List<MusicModels> data =
          response.docs
              .map((e) => MusicModels.fromMap(e.data() as Map<String, dynamic>))
              .toList();

      return data;
    } catch (e) {
      throw ServerFailure(failure: e.toString());
    }
  }
}
