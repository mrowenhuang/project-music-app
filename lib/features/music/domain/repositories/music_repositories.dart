import 'package:dartz/dartz.dart';
import 'package:flutter_music_app/core/failure/server_failure.dart';
import 'package:flutter_music_app/features/music/data/models/music_models.dart';
import 'package:flutter_music_app/features/music/domain/entities/music_entites.dart';
import 'package:flutter_music_app/features/music/domain/entities/playlist_entites.dart';


abstract class MusicRepositories {
  Future <Either<ServerFailure,List<MusicEntites>>> getMusic ();
  Future <Either<ServerFailure,List<MusicEntites>>> getDeviceMusic();
  Future <Either<ServerFailure,String>> addPlaylist(String playlistName);
  Future <Either<ServerFailure,List<PlaylistEntites>>> getPlaylist();
  Future <Either<ServerFailure,String>> deletePlaylist(String id);
  Future <Either<ServerFailure,String>> addMusicToPlaylist(String id, MusicModels music);
}