import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'music_event.dart';
part 'music_state.dart';

class MusicBloc extends Bloc<MusicEvent, MusicState> {
  MusicBloc() : super(MusicInitial()) {
    on<MusicEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
