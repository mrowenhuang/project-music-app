import 'package:dartz/dartz.dart';
import 'package:flutter_music_app/core/failure/server_failure.dart';
import 'package:flutter_music_app/features/music/domain/repositories/music_repositories.dart';

class PlaylistMusicAdd {
  final MusicRepositories _musicRepositories;

  PlaylistMusicAdd(this._musicRepositories);

  Future<Either<ServerFailure, String>> call(String playlistName) async {
    return await _musicRepositories.addPlaylist(playlistName);
  }
}
