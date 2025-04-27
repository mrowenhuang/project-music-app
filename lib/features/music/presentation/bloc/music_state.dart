part of 'music_bloc.dart';

abstract class MusicState extends Equatable {
  const MusicState();

  @override
  List<Object> get props => [];
}

class MusicInitial extends MusicState {}

// ^ Online music

class SuccesGetOnlineMusicState extends MusicState {
  final List<MusicEntites> music;

  const SuccesGetOnlineMusicState({required this.music});
}

class LoadingGetOnlineMusicState extends MusicState {}

class FailedGetOnlineMusicState extends MusicState {
  final String failure;

  const FailedGetOnlineMusicState({required this.failure});
}

// ^ Offline music

class SuccesGetOfflineMusicState extends MusicState {
  final List<MusicEntites> music;

  const SuccesGetOfflineMusicState({required this.music});
}

class LoadingGetOfflineMusicState extends MusicState {}

class FailedGetOfflineMusicState extends MusicState {
  final String failure;

  const FailedGetOfflineMusicState({required this.failure});
}


// ^ universal loading 

class LoadingGetMusicState extends MusicState {}

