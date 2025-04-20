import 'dart:convert';

import 'package:flutter_music_app/features/music/domain/entities/music_entites.dart';
import 'package:on_audio_query/on_audio_query.dart';

// ignore: must_be_immutable
class MusicModels extends MusicEntites {
  MusicModels({
    super.id,
    super.title,
    super.artist,
    super.data,
    super.poster,
    super.playing,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'title': title,
      'artist': artist,
      '_data': data,
      'poster': poster,
      'playing': playing,
    };
  }

  factory MusicModels.fromMap(Map<String, dynamic> map) {
    return MusicModels(
      id: map['_id'] != null ? map['_id'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      artist: map['artist'] != null ? map['artist'] as String : null,
      data: map['_data'] != null ? map['_data'] as String : null,
      poster: map['poster'] != null ? map['poster'] as String : null,
      playing: map['playing'] != null ? map['playing'] as bool : null,
    );
  }

  factory MusicModels.fromSongModel(SongModel song) {
    return MusicModels(
      id: song.id.toString(),
      title: song.title,
      artist: song.artist,
      data: song.data,
      poster: null,
      playing: null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MusicModels.fromJson(String source) =>
      MusicModels.fromMap(json.decode(source) as Map<String, dynamic>);
}
