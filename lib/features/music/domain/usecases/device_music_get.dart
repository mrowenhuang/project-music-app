import 'package:dartz/dartz.dart';
import 'package:flutter_music_app/core/failure/server_failure.dart';
import 'package:flutter_music_app/features/music/domain/entities/music_entites.dart';
import 'package:flutter_music_app/features/music/domain/repositories/music_repositories.dart';

class DeviceMusicGet {
  final MusicRepositories _musicRepositories;

  DeviceMusicGet(this._musicRepositories);

  Future<Either<ServerFailure, List<MusicEntites>>> call() async {
    return await _musicRepositories.getDeviceMusic();
  }
}
