part of 'music_bloc.dart';

abstract class MusicEvent extends Equatable {
  const MusicEvent();

  @override
  List<Object> get props => [];
}

final class GetOnlineMusicEvent extends MusicEvent {}

final class GetOfflineMusicEvent extends MusicEvent {}

