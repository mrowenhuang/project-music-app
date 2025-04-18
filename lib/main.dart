import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_music_app/common/playing/cubit/playing_cubit.dart';
import 'package:flutter_music_app/core/configs/app_theme.dart';
import 'package:flutter_music_app/features/music/presentation/bloc/music_bloc.dart';
import 'package:flutter_music_app/features/music/presentation/pages/home_pages.dart';
import 'package:flutter_music_app/features/music/presentation/pages/home_pages2.dart';
import 'package:flutter_music_app/features/music/presentation/pages/test_page.dart';
import 'package:flutter_music_app/injection.dart';
import 'package:just_audio_background/just_audio_background.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initializeDependecies();
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<MusicBloc>()..add(GetOnlineMusicEvent()),
        ),
        BlocProvider(create: (context) => sl<PlayingCubit>()),
      ],

      child: MaterialApp(
        title: 'Music App',
        theme: AppTheme.appTheme(context),
        debugShowCheckedModeBanner: false,
        home: const HomePages(),
      ),
    );
  }
}
