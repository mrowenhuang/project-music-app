import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_music_app/features/music/domain/entities/music_entites.dart';

part 'switch_state.dart';

class SwitchCubit extends Cubit<bool> {
  SwitchCubit() : super(true);

  void toggleSwitch(bool value) {
    emit(value);
  }
}
