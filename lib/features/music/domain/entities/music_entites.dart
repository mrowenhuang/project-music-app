// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class MusicEntites extends Equatable {
  String? id;
  String? title;
  String? artist;
  String? data;
  String? poster;
  bool? playing;
  MusicEntites({
    this.id,
    this.title,
    this.artist,
    this.data,
    this.poster,
    this.playing,
  });

  @override
  List<Object?> get props => [id, title, artist, data, poster, playing];




}
