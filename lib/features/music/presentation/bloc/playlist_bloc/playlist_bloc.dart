import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_music_app/features/music/data/models/music_models.dart';
import 'package:flutter_music_app/features/music/domain/entities/playlist_entites.dart';
import 'package:flutter_music_app/features/music/domain/usecases/music_to_playlist_add.dart';
import 'package:flutter_music_app/features/music/domain/usecases/playlist_music_delete.dart';

import 'package:flutter_music_app/features/music/domain/usecases/playlist_music_add.dart';
import 'package:flutter_music_app/features/music/domain/usecases/playlist_music_get.dart';

part 'playlist_event.dart';
part 'playlist_state.dart';

class PlaylistBloc extends Bloc<PlaylistEvent, PlaylistState> {
  final PlaylistMusicAdd _playlistMusicAdd;
  final PlaylistMusicGet _playlistMusicGet;
  final PlaylistMusicDelete _playlistMusicDelete;
  final MusicToPlaylistAdd _musicToPlaylistAdd;

  PlaylistBloc(
    this._playlistMusicAdd,
    this._playlistMusicGet,
    this._playlistMusicDelete,
    this._musicToPlaylistAdd,
  ) : super(PlaylistInitial()) {
    on<AddPlaylistEvent>(addPlaylistEvent);
    on<GetPlaylistEvent>(getPlaylistEvent);
    on<DeletePlaylistEvent>(deletePlaylistEvent);
    on<AddMusicToPlaylistEvent>(addMusicToPlaylistEvent);
  }

  FutureOr<void> addPlaylistEvent(
    AddPlaylistEvent event,
    Emitter<PlaylistState> emit,
  ) async {
    emit(LoadingPlaylistState());
    final response = await _playlistMusicAdd.call(event.playlistName);

    await response.fold(
      (failure) {
        emit(FailedAddPlaylistState(failure: failure.failure));
      },
      (response) async {
        emit(SuccesAddPlaylistState(message: response));
        final data = await _playlistMusicGet.call();
        await data.fold(
          (failure) async {
            emit(FailedGetPlaylistState(failure: failure.failure));
          },
          (response) async {
            emit(SuccesGetPlaylistState(palylist: response));
          },
        );
      },
    );
  }

  FutureOr<void> getPlaylistEvent(
    GetPlaylistEvent event,
    Emitter<PlaylistState> emit,
  ) async {
    emit(LoadingPlaylistState());
    final response = await _playlistMusicGet.call();

    response.fold(
      (failure) {
        emit(FailedGetPlaylistState(failure: failure.failure));
      },
      (response) {
        emit(SuccesGetPlaylistState(palylist: response));
      },
    );
  }

  FutureOr<void> deletePlaylistEvent(
    DeletePlaylistEvent event,
    Emitter<PlaylistState> emit,
  ) async {
    emit(LoadingPlaylistState());
    final response = await _playlistMusicDelete.call(event.id);

    await response.fold(
      (failure) {
        emit(FailedDeletePlaylistState(failure: failure.failure));
      },
      (response) async {
        emit(SuccesDeletePlaylistState(message: response));
        final data = await _playlistMusicGet.call();
        await data.fold(
          (failure) async {
            emit(FailedGetPlaylistState(failure: failure.failure));
          },
          (response) async {
            emit(SuccesGetPlaylistState(palylist: response));
          },
        );
      },
    );
  }

  FutureOr<void> addMusicToPlaylistEvent(
    AddMusicToPlaylistEvent event,
    Emitter<PlaylistState> emit,
  ) async {
    emit(LoadingPlaylistState());

    final response = await _musicToPlaylistAdd.call(event.id, event.music);

    await response.fold(
      (failure) {
        emit(FailedAddMusicToPlaylistState(failure: failure.failure));
      },
      (response) async {
        emit(SuccesAddMusicToPlaylistState(message: response));
        final data = await _playlistMusicGet.call();
        data.fold(
          (failure) {
            emit(FailedGetPlaylistState(failure: failure.failure));
          },
          (response) {
            emit(SuccesGetPlaylistState(palylist: response));
          },
        );
      },
    );
  }
}
