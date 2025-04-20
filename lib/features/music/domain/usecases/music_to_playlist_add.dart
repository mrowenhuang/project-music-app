import 'package:dartz/dartz.dart';
import 'package:flutter_music_app/core/failure/server_failure.dart';
import 'package:flutter_music_app/features/music/data/models/music_models.dart';
import 'package:flutter_music_app/features/music/domain/repositories/music_repositories.dart';

class MusicToPlaylistAdd {
  final MusicRepositories _musicRepositories;

  MusicToPlaylistAdd(this._musicRepositories);

  Future<Either<ServerFailure, String>> call(
    String id,
    MusicModels music,
  ) async {
    return await _musicRepositories.addMusicToPlaylist(id, music);
  }
}
