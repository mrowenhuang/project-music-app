part of 'search_bloc.dart';

sealed class SearchState extends Equatable {
  const SearchState();
  
  @override
  List<Object> get props => [];
}

final class SearchInitial extends SearchState {}



final class LoadingGetSearchMusicState  extends SearchState{
  
}

final class SuccessGetSearchMusicState extends SearchState {
  final List<MusicEntites> music;

  const SuccessGetSearchMusicState({required this.music});
}

final class FailedGetSearchMusicState extends SearchState {
  final String failure;

  const FailedGetSearchMusicState({required this.failure});
}