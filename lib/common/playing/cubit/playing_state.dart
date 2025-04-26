part of 'playing_cubit.dart';

sealed class PlayingState extends Equatable {
  const PlayingState();

  @override
  List<Object> get props => [];
}

final class PlayingInitial extends PlayingState {}

final class MusicPlayingNowState extends PlayingState {
  final List<MusicEntites> music;

  const MusicPlayingNowState({required this.music});
}

final class MuicPlayingPlaylistNowState extends PlayingState {
  final PlaylistEntites playlist;
  // final ConcatenatingAudioSource musicPlaylist;
  final int index;

  const MuicPlayingPlaylistNowState({
    required this.index,
    required this.playlist,
    // required this.musicPlaylist,
  });
}

final class MusicLoadingNowState extends PlayingState {}
