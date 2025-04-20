import 'package:dartz/dartz.dart';
import 'package:flutter_music_app/core/failure/server_failure.dart';
import 'package:flutter_music_app/features/music/domain/repositories/music_repositories.dart';

class PlaylistMusicDelete {
  final MusicRepositories _musicRepositories;

  PlaylistMusicDelete(this._musicRepositories);


  Future<Either<ServerFailure,String>> call (String id) async {
    return await _musicRepositories.deletePlaylist(id);
  }
}