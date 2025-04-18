import 'package:dartz/dartz.dart';
import 'package:flutter_music_app/core/failure/server_failure.dart';
import 'package:flutter_music_app/features/music/domain/repositories/music_repositories.dart';
import 'package:on_audio_query/on_audio_query.dart';

class DeviceMusicGet {
  final MusicRepositories _musicRepositories;

  DeviceMusicGet(this._musicRepositories);

  Future<Either<ServerFailure, List<SongModel>>> call() async {
    return await _musicRepositories.getDeviceMusic();
  }
}
