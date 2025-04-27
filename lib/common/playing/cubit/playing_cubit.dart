import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_music_app/features/music/domain/entities/music_entites.dart';
import 'package:flutter_music_app/features/music/domain/entities/playlist_entites.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

part 'playing_state.dart';

class PlayingCubit extends Cubit<PlayingState> {
  PlayingCubit() : super(PlayingInitial());
  final AudioPlayer audioPlayer = AudioPlayer();

  void playing(MusicEntites music) async {
    audioPlayer.playerStateStream.listen((playerState) async {
      if (playerState.processingState == ProcessingState.completed) {
        music.playing = false;
        emit(MusicLoadingNowState());
        emit(MusicPlayingNowState(music: [music]));
        await audioPlayer.pause();
      }
    });

    final currentSource = audioPlayer.audioSource;
    String? currentUri;
    if (currentSource is UriAudioSource) {
      currentUri = currentSource.uri.toString();
    }

    final clickedUri = music.data.toString();

    if (currentUri == clickedUri) {
      if (audioPlayer.playing) {
        music.playing = false;
        emit(MusicLoadingNowState());
        emit(MusicPlayingNowState(music: [music]));
        await audioPlayer.pause();
      } else {
        music.playing = true;
        emit(MusicLoadingNowState());
        emit(MusicPlayingNowState(music: [music]));
        await audioPlayer.play();
      }
    } else {
      // Lagu beda
      await audioPlayer.stop();
      await audioPlayer.setAudioSource(
        AudioSource.uri(
          Uri.parse(clickedUri),
          tag: MediaItem(
            id: music.title ?? '',
            title: music.title ?? '',
            artist: music.artist,
            artUri:
                music.poster == null
                    ? Uri.file("asset://assets/images/music.png")
                    : Uri.parse(music.poster.toString()),
          ),
        ),
      );
      music.playing = true;
      emit(MusicLoadingNowState());
      emit(MusicPlayingNowState(music: [music]));
      await audioPlayer.play();
    }

    emit(MusicLoadingNowState());
    emit(MusicPlayingNowState(music: [music]));
  }

  void playingPlaylist(PlaylistEntites playlist, int index) async {
    await audioPlayer.stop();

    audioPlayer.currentIndexStream.listen((currentIndex) {
      if (currentIndex != null && currentIndex != index) {
        nextSong();
      }
    });
    emit(MusicLoadingNowState());
    final musicPlaylist = ConcatenatingAudioSource(
      children:
          playlist.listMusic!
              .map(
                (e) => AudioSource.uri(
                  Uri.parse(e.data.toString()),
                  tag: MediaItem(
                    id: e.id.toString(),
                    title: e.title.toString(),
                    artist: e.artist.toString(),
                    artUri: Uri.parse(e.poster.toString()),
                  ),
                ),
              )
              .toList(),
    );

    await audioPlayer.setAudioSource(
      musicPlaylist,
      initialIndex: index,
      initialPosition: Duration.zero,
    );
    for (var i = 0; i < playlist.listMusic!.length; i++) {
      playlist.listMusic![i].playing = i == index;
    }
    emit(MusicPlayingPlaylistNowState(playlist: playlist, index: index));
    await audioPlayer.play();
  }

  void togglePlayMusic() async {
    if (audioPlayer.playing) {
      updatePlayingStatus(false);

      await audioPlayer.pause();
    } else {
      updatePlayingStatus(true);

      await audioPlayer.play();
    }
  }

  void revTogglePlayMusic() async {
    if (audioPlayer.playing) {
      updatePlayingStatus(true);
    } else {
      updatePlayingStatus(false);
    }
  }

  void updatePlayingStatus(bool isPlaying) async {
    if (state is MusicPlayingPlaylistNowState) {
      final currentState = state as MusicPlayingPlaylistNowState;
      final playlist = currentState.playlist;
      final index = currentState.index;

      playlist.listMusic![index].playing = isPlaying;
      emit(MusicLoadingNowState());
      emit(MusicPlayingPlaylistNowState(playlist: playlist, index: index));
    }
  }

  void nextSong() async {
    if (state is MusicPlayingPlaylistNowState) {
      final currentState = state as MusicPlayingPlaylistNowState;
      final playlist = currentState.playlist;
      final index = currentState.index;

      if (index < playlist.listMusic!.length - 1) {
        emit(MusicLoadingNowState());
        emit(
          MusicPlayingPlaylistNowState(playlist: playlist, index: index + 1),
        );
        revTogglePlayMusic();
        await audioPlayer.seekToNext();
      }
    }
  }

  void prevSong() async {
    if (state is MusicPlayingPlaylistNowState) {
      final currentState = state as MusicPlayingPlaylistNowState;
      final playlist = currentState.playlist;
      final index = currentState.index;

      if (index > 0) {
        emit(MusicLoadingNowState());
        emit(
          MusicPlayingPlaylistNowState(playlist: playlist, index: index - 1),
        );
        revTogglePlayMusic();
        await audioPlayer.seekToPrevious();
      }
    }
  }
}
