part of 'playlist_bloc.dart';

sealed class PlaylistEvent extends Equatable {
  const PlaylistEvent();

  @override
  List<Object> get props => [];
}

final class AddPlaylistEvent extends PlaylistEvent {
  final String playlistName;

  const AddPlaylistEvent({required this.playlistName});
}

final class GetPlaylistEvent extends PlaylistEvent {}

final class DeletePlaylistEvent extends PlaylistEvent {
  final String id;

  const DeletePlaylistEvent({required this.id});
}

final class AddMusicToPlaylistEvent extends PlaylistEvent {
  final String id;
  final MusicModels music;

  const AddMusicToPlaylistEvent({required this.id, required this.music});
}
