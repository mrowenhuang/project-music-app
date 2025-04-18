import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_music_app/common/playing/cubit/playing_cubit.dart';
import 'package:flutter_music_app/features/music/data/datasources/remote/music_remote_datasource.dart';
import 'package:flutter_music_app/features/music/data/repositories/music_repositories_impl.dart';
import 'package:flutter_music_app/features/music/domain/repositories/music_repositories.dart';
import 'package:flutter_music_app/features/music/domain/usecases/device_music_get.dart';
import 'package:flutter_music_app/features/music/domain/usecases/music_get.dart';
import 'package:flutter_music_app/features/music/presentation/bloc/music_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:on_audio_query/on_audio_query.dart';

final sl = GetIt.instance;

Future<void> initializeDependecies() async {
  sl.registerLazySingleton(() => OnAudioQuery());
  // sl.registerLazySingleton(() => FirebaseFirestore.instance);

  sl.registerFactory(() => MusicBloc(sl(), sl()));
  sl.registerFactory(() => PlayingCubit());

  sl.registerLazySingleton<MusicRemoteDatasource>(
    () => MusicRemoteDatasourceImpl(),
  );

  sl.registerLazySingleton<MusicRepositories>(
    () => MusicRepositoriesImpl(sl(), sl()),
  );

  sl.registerLazySingleton(() => MusicGet(sl()));
  sl.registerLazySingleton(() => DeviceMusicGet(sl()));
}
