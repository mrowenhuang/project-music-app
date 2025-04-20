part of 'playlist_bloc.dart';

sealed class PlaylistState extends Equatable {
  const PlaylistState();

  @override
  List<Object> get props => [];
}

final class PlaylistInitial extends PlaylistState {}

final class LoadingPlaylistState extends PlaylistState {}

final class SuccesAddPlaylistState extends PlaylistState {
  final String message;

  const SuccesAddPlaylistState({required this.message});
}

final class FailedAddPlaylistState extends PlaylistState {
  final String failure;

  const FailedAddPlaylistState({required this.failure});
}

final class SuccesGetPlaylistState extends PlaylistState {
  final List<PlaylistEntites> palylist;

  const SuccesGetPlaylistState({required this.palylist});
}

final class FailedGetPlaylistState extends PlaylistState {
  final String failure;

  const FailedGetPlaylistState({required this.failure});
}

final class SuccesDeletePlaylistState extends PlaylistState {
  final String message;

  const SuccesDeletePlaylistState({required this.message});
}

final class FailedDeletePlaylistState extends PlaylistState {
  final String failure;

  const FailedDeletePlaylistState({required this.failure});
}

final class SuccesAddMusicToPlaylistState extends PlaylistState {
  final String message;

  const SuccesAddMusicToPlaylistState({required this.message});
}

final class FailedAddMusicToPlaylistState extends PlaylistState {
  final String failure;

  const FailedAddMusicToPlaylistState({required this.failure});
}