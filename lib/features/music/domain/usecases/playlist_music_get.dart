import 'package:dartz/dartz.dart';
import 'package:flutter_music_app/core/failure/server_failure.dart';
import 'package:flutter_music_app/features/music/domain/entities/playlist_entites.dart';
import 'package:flutter_music_app/features/music/domain/repositories/music_repositories.dart';

class PlaylistMusicGet {
  final MusicRepositories _musicRepositories;

  PlaylistMusicGet(this._musicRepositories);

  Future<Either<ServerFailure, List<PlaylistEntites>>> call() async {
    return await _musicRepositories.getPlaylist();
  }
}
