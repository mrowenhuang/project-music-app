// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_music_app/features/music/data/models/music_models.dart';
import 'package:flutter_music_app/features/music/domain/entities/music_entites.dart';
import 'package:flutter_music_app/features/music/domain/entities/playlist_entites.dart';

// ignore: must_be_immutable
class PlaylistModels extends PlaylistEntites {
  PlaylistModels({super.id, super.listMusic, super.playlistName});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'playlist_name': playlistName,
      'list_music': listMusic?.map((x) => (x as MusicModels).toMap()).toList(),
    };
  }

  factory PlaylistModels.fromMap(Map<String, dynamic> map) {
    return PlaylistModels(
      id: map['id'] != null ? map['id'] as String : null,
      playlistName:
          map['playlist_name'] != null ? map['playlist_name'] as String : null,
      listMusic:
          map['list_music'] != null
              ? List<MusicEntites>.from(
                (map['list_music'] as List).map(
                  (x) => MusicModels.fromMap(x as Map<String, dynamic>),
                ),
              )
              : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PlaylistModels.fromJson(String source) =>
      PlaylistModels.fromMap(json.decode(source) as Map<String, dynamic>);
}
