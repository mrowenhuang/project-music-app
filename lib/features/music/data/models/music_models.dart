import 'package:flutter_music_app/features/music/domain/entities/music_entites.dart';

// ignore: must_be_immutable
class MusicModels implements MusicEntites {
  @override
  String? artist;

  @override
  String? poster;

  @override
  String? title;

  @override
  String? url;

  @override
  bool? playing;

  @override
  List<Object?> get props => throw UnimplementedError();

  @override
  bool? get stringify => throw UnimplementedError();

  MusicModels({this.title, this.artist, this.url, this.poster,this.playing});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'artist': artist,
      'url': url,
      'poster': poster,
      'playing': playing,
    };
  }

  factory MusicModels.fromMap(Map<String, dynamic> map) {
    return MusicModels(
      title: map['title'] != null ? map['title'] as String : null,
      artist: map['artist'] != null ? map['artist'] as String : null,
      url: map['url'] != null ? map['url'] as String : null,
      poster: map['poster'] != null ? map['poster'] as String : null,
      playing: map['playing'] != null ? map['playing'] as bool : null,
    );
  }
}
