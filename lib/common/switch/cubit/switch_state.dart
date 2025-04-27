part of 'switch_cubit.dart';

sealed class SwitchState extends Equatable {
  const SwitchState();

  @override
  List<Object> get props => [];
}

final class SearchInitial extends SwitchState {}

final class LoadingSearchMusicState extends SwitchState {}

final class SuccessChangeTypeStatusState extends SwitchState {
  final bool status;

  const SuccessChangeTypeStatusState({this.status = true});
}

final class SuccessSearchMusicState extends SwitchState {
  final MusicEntites music;

  const SuccessSearchMusicState({required this.music});
}
