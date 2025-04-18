import 'package:dartz/dartz.dart';
import 'package:flutter_music_app/core/failure/server_failure.dart';
import 'package:flutter_music_app/features/music/domain/entities/music_entites.dart';
import 'package:on_audio_query/on_audio_query.dart';


abstract class MusicRepositories {
  Future <Either<ServerFailure,List<MusicEntites>>> getMusic ();
  Future <Either<ServerFailure,List<SongModel>>> getDeviceMusic();

}