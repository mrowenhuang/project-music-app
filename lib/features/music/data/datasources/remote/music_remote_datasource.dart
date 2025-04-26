// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_music_app/core/failure/server_failure.dart';
import 'package:flutter_music_app/features/music/data/models/music_models.dart';
import 'package:flutter_music_app/features/music/data/models/playlist_models.dart';

abstract class MusicRemoteDatasource {
  Future<List<MusicModels>> getMusic();
  Future<List<PlaylistModels>> getPlaylist();
  Future<String> addPlaylist(String playlistName);
  Future<String> deletePlaylist(String id);
  Future<String> addMusicToPlaylist(String id, MusicModels music);
}

class MusicRemoteDatasourceImpl implements MusicRemoteDatasource {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<List<MusicModels>> getMusic() async {
    try {
      final CollectionReference coll = firestore.collection('musics');
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

  @override
  Future<String> addPlaylist(String playlistName) async {
    try {
      final CollectionReference coll = firestore.collection('playlist');

      await coll.add({
        "id": DateTime.now().toIso8601String(),
        "playlist_name": playlistName,
        "list_music": [],
      });

      return "Success";
    } catch (e) {
      throw ServerFailure(failure: e.toString());
    }
  }

  @override
  Future<List<PlaylistModels>> getPlaylist() async {
    try {
      final CollectionReference coll = firestore.collection('playlist');

      final response = await coll.get();
      final List<PlaylistModels> data =
          response.docs
              .map(
                (e) => PlaylistModels.fromMap(e.data() as Map<String, dynamic>),
              )
              .toList();
      return data;
    } catch (e) {
      throw (ServerFailure(failure: e.toString()));
    }
  }

  @override
  Future<String> deletePlaylist(String id) async {
    try {
      final CollectionReference coll = firestore.collection('playlist');

      await coll.get().then((value) async {
        for (var data in value.docs) {
          if ((data.data() as Map<String, dynamic>)['id'] == id) {
            await coll.doc(data.id).delete();
          }
        }
      });

      return "Success";
    } catch (e) {
      throw ServerFailure(failure: e.toString());
    }
  }

  @override
  Future<String> addMusicToPlaylist(String id, MusicModels music) async {
    try {
      final CollectionReference coll = firestore.collection('playlist');

      await coll.get().then((value) async {
        for (var data in value.docs) {
          if ((data.data() as Map<String, dynamic>)['id'] == id) {
            if (((data.data() as Map<String, dynamic>)['list_music'] as List)
                .isEmpty) {
              await coll.doc(data.id).update({
                'list_music': FieldValue.arrayUnion([music.toMap()]),
              });
            } else {
              for (var element
                  in (data.data() as Map<String, dynamic>)['list_music']) {
                if (element['_id'] != music.id || true) {
                  await coll.doc(data.id).update({
                    'list_music': FieldValue.arrayUnion([music.toMap()]),
                  });
                }
              }
            }
          }
        }
      });
      return "Success";
    } catch (e) {
      throw ServerFailure(failure: e.toString());
    }
  }
}
