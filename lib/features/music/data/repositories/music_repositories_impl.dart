import 'package:dartz/dartz.dart';
import 'package:flutter_music_app/core/failure/server_failure.dart';
import 'package:flutter_music_app/features/music/data/datasources/remote/music_remote_datasource.dart';
import 'package:flutter_music_app/features/music/data/models/music_models.dart';
import 'package:flutter_music_app/features/music/domain/entities/music_entites.dart';
import 'package:flutter_music_app/features/music/domain/entities/playlist_entites.dart';
import 'package:flutter_music_app/features/music/domain/repositories/music_repositories.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class MusicRepositoriesImpl implements MusicRepositories {
  final MusicRemoteDatasource _musicRemoteDatasource;
  final OnAudioQuery _onAudioQuery;

  MusicRepositoriesImpl(this._musicRemoteDatasource, this._onAudioQuery);

  @override
  Future<Either<ServerFailure, List<MusicEntites>>> getMusic() async {
    try {
      final response = await _musicRemoteDatasource.getMusic();
      return right(response);
    } catch (e) {
      return left(ServerFailure(failure: e.toString()));
    }
  }

  @override
  Future<Either<ServerFailure, List<MusicEntites>>> getDeviceMusic() async {
    try {
      if (await Permission.audio.isGranted ||
          await Permission.storage.isGranted) {
        final List<SongModel> response = await _onAudioQuery.querySongs();
        final List<MusicEntites> data =
            response.map((e) => MusicModels.fromSongModel(e)).toList();

        return right(data);
      } else if (await Permission.audio.isDenied ||
          await Permission.storage.isDenied) {
        await Permission.storage.request();
        await Permission.audio.request();
        final List<SongModel> response = await _onAudioQuery.querySongs();
        final List<MusicEntites> data =
            response.map((e) => MusicModels.fromSongModel(e)).toList();
        return right(data);
      } else {
        return left(ServerFailure(failure: "Cant access device music"));
      }
    } catch (e) {
      return left(ServerFailure(failure: e.toString()));
    }
  }

  @override
  Future<Either<ServerFailure, String>> addPlaylist(String playlistName) async {
    try {
      final response = await _musicRemoteDatasource.addPlaylist(playlistName);

      return right(response);
    } catch (e) {
      return left(ServerFailure(failure: e.toString()));
    }
  }

  @override
  Future<Either<ServerFailure, List<PlaylistEntites>>> getPlaylist() async {
    try {
      final response = await _musicRemoteDatasource.getPlaylist();

      return right(response);
    } catch (e) {
      return left(ServerFailure(failure: e.toString()));
    }
  }

  @override
  Future<Either<ServerFailure, String>> deletePlaylist(String id) async {
    try {
      final response = await _musicRemoteDatasource.deletePlaylist(id);
      return right(response);
    } catch (e) {
      return left(ServerFailure(failure: e.toString()));
    }
  }

  @override
  Future<Either<ServerFailure, String>> addMusicToPlaylist(
    String id,
    MusicModels music,
  ) async {
    try {
      final response = await _musicRemoteDatasource.addMusicToPlaylist(
        id,
        music,
      );

      return right(response);
    } catch (e) {
      return left(ServerFailure(failure: e.toString()));
    }
  }
}
