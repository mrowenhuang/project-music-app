part of 'search_bloc.dart';

sealed class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}


final class GetSearchMusicEvent extends SearchEvent {
  final String text;
  final bool type;

  const GetSearchMusicEvent( {required this.text, required this.type,});
}
