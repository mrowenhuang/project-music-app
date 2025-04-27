import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_music_app/features/music/domain/entities/music_entites.dart';
import 'package:flutter_music_app/features/music/domain/usecases/device_music_get.dart';
import 'package:flutter_music_app/features/music/domain/usecases/music_get.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final MusicGet _musicGet;
  final DeviceMusicGet _deviceMusicGet;

  SearchBloc(this._musicGet, this._deviceMusicGet) : super(SearchInitial()) {
    on<GetSearchMusicEvent>(getSearchMusicEvent);
  }

  FutureOr<void> getSearchMusicEvent(
    GetSearchMusicEvent event,
    Emitter<SearchState> emit,
  ) async {
    emit(LoadingGetSearchMusicState());

    if (event.type) {
      final response = await _musicGet.call();

      response.fold(
        (failure) {
          emit(FailedGetSearchMusicState(failure: failure.toString()));
        },
        (response) {
          List<MusicEntites> filteredMusic =
              response.where((musicItem) {
                // Filter berdasarkan title atau artist, misalnya:
                return musicItem.title.toString().toLowerCase().contains(
                      event.text.toLowerCase(),
                    ) ||
                    musicItem.artist.toString().toLowerCase().contains(
                      event.text.toLowerCase(),
                    );
              }).toList();

          emit(SuccessGetSearchMusicState(music: filteredMusic));
        },
      );
    } else {
      final response = await _deviceMusicGet.call();
      print("Ofline");
      response.fold(
        (failure) {
          emit(FailedGetSearchMusicState(failure: failure.toString()));
        },
        (response) {
          print(response);
          List<MusicEntites> filteredMusic =
              response.where((musicItem) {
                return musicItem.title.toString().toLowerCase().contains(
                      event.text.toLowerCase(),
                    ) ||
                    musicItem.artist.toString().toLowerCase().contains(
                      event.text.toLowerCase(),
                    );
              }).toList();

          emit(SuccessGetSearchMusicState(music: filteredMusic));
        },
      );
    }
  }
}
