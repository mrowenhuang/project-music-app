import 'package:flutter_music_app/common/playing/cubit/playing_cubit.dart';
import 'package:flutter_music_app/common/switch/cubit/switch_cubit.dart';
import 'package:flutter_music_app/features/music/data/datasources/remote/music_remote_datasource.dart';
import 'package:flutter_music_app/features/music/data/repositories/music_repositories_impl.dart';
import 'package:flutter_music_app/features/music/domain/repositories/music_repositories.dart';
import 'package:flutter_music_app/features/music/domain/usecases/device_music_get.dart';
import 'package:flutter_music_app/features/music/domain/usecases/music_get.dart';
import 'package:flutter_music_app/features/music/domain/usecases/music_to_playlist_add.dart';
import 'package:flutter_music_app/features/music/domain/usecases/playlist_music_add.dart';
import 'package:flutter_music_app/features/music/domain/usecases/playlist_music_delete.dart';
import 'package:flutter_music_app/features/music/domain/usecases/playlist_music_get.dart';
import 'package:flutter_music_app/features/music/presentation/bloc/music_bloc.dart';
import 'package:flutter_music_app/features/music/presentation/bloc/playlist_bloc/playlist_bloc.dart';
import 'package:flutter_music_app/features/music/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

final sl = GetIt.instance;

Future<void> initializeDependecies() async {
  sl.registerLazySingleton(() => OnAudioQuery());
  sl.registerLazySingleton(() => AudioPlayer());
  // sl.registerLazySingleton(() => FirebaseFirestore.instance);

  sl.registerFactory(() => MusicBloc(sl(), sl()));
  sl.registerFactory(() => PlayingCubit());
  sl.registerFactory(() => SwitchCubit());
  sl.registerFactory(() => PlaylistBloc(sl(), sl(), sl(), sl()));
  sl.registerFactory(() => SearchBloc(sl(), sl()));

  sl.registerLazySingleton<MusicRemoteDatasource>(
    () => MusicRemoteDatasourceImpl(),
  );

  sl.registerLazySingleton<MusicRepositories>(
    () => MusicRepositoriesImpl(sl(), sl()),
  );

  sl.registerLazySingleton(() => MusicGet(sl()));
  sl.registerLazySingleton(() => DeviceMusicGet(sl()));
  sl.registerLazySingleton(() => PlaylistMusicAdd(sl()));
  sl.registerLazySingleton(() => PlaylistMusicGet(sl()));
  sl.registerLazySingleton(() => PlaylistMusicDelete(sl()));
  sl.registerLazySingleton(() => MusicToPlaylistAdd(sl()));
}
