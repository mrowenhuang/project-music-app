import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_music_app/features/music/domain/entities/music_entites.dart';
import 'package:flutter_music_app/features/music/domain/entities/playlist_entites.dart';

part 'playing_state.dart';

class PlayingCubit extends Cubit<PlayingState> {
  PlayingCubit() : super(PlayingInitial());

  void playing(MusicEntites music) {
    emit(MusicLoadingNowState());

    if (music.playing == null) {
      music.playing = true;
      emit(MusicPlayingNowState(music: [music]));
    } else {
      music.playing = !music.playing!;
      emit(MusicPlayingNowState(music: [music]));
    }
  }

  void playingPlaylist(PlaylistEntites playlist, int index) {
    emit(MusicLoadingNowState());

    emit(MuicPlayingPlaylistNowState(playlist: playlist, index: index));
  }
}
