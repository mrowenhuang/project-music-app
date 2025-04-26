// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

import 'package:flutter_music_app/features/music/domain/entities/music_entites.dart';

// ignore: must_be_immutable
class PlaylistEntites extends Equatable {
  String? id;
  String? playlistName;
  List<MusicEntites>? listMusic;

  PlaylistEntites({this.id, this.playlistName, this.listMusic});

  @override
  List<Object?> get props => [id, playlistName, listMusic];
}
