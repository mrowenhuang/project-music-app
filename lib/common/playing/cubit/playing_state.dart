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

// ignore: must_be_immutable
final class MusicPlayingPlaylistNowState extends PlayingState {
  final PlaylistEntites playlist;
  // final ConcatenatingAudioSource musicPlaylist;
  int index;

  MusicPlayingPlaylistNowState({
    required this.index,
    required this.playlist,
    // required this.musicPlaylist,
  });
}

final class MusicLoadingNowState extends PlayingState {}
