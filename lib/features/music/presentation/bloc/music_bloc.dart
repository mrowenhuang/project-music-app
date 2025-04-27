import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_music_app/features/music/domain/entities/music_entites.dart';
import 'package:flutter_music_app/features/music/domain/usecases/device_music_get.dart';
import 'package:flutter_music_app/features/music/domain/usecases/music_get.dart';

part 'music_event.dart';
part 'music_state.dart';

class MusicBloc extends Bloc<MusicEvent, MusicState> {
  final MusicGet _musicGet;
  final DeviceMusicGet _deviceMusicGet;

  MusicBloc(this._musicGet, this._deviceMusicGet) : super(MusicInitial()) {
    on<GetOnlineMusicEvent>(getOnlineMusicEvent);
    on<GetOfflineMusicEvent>(getOfflineMusicEvent);
  }

  FutureOr<void> getOnlineMusicEvent(
    GetOnlineMusicEvent event,
    Emitter<MusicState> emit,
  ) async {
    emit(LoadingGetMusicState());
    final response = await _musicGet.call();

    response.fold(
      (failure) {
        emit(FailedGetOnlineMusicState(failure: failure.toString()));
      },
      (response) {
        emit(SuccesGetOnlineMusicState(music: response));
      },
    );
  }

  FutureOr<void> getOfflineMusicEvent(
    GetOfflineMusicEvent event,
    Emitter<MusicState> emit,
  ) async {
    emit(LoadingGetMusicState());

    final response = await _deviceMusicGet.call();

    response.fold(
      (failure) {
        emit(FailedGetOfflineMusicState(failure: failure.toString()));
      },
      (response) {
        print(response);
        emit(SuccesGetOfflineMusicState(music: response));
      },
    );
  }
}
