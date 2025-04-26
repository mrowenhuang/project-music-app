import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_music_app/common/playing/cubit/playing_cubit.dart';
import 'package:flutter_music_app/core/configs/app_color.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:marquee/marquee.dart';

Widget musicPlayingBox(BuildContext context, AudioPlayer audioPlayer) {
  return BlocBuilder<PlayingCubit, PlayingState>(
    bloc: context.read<PlayingCubit>(),
    builder: (context, state) {
      if (state is MusicPlayingNowState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Music Playing', style: TextStyle(fontSize: 16)),
            SizedBox(height: 15),
            Container(
              width: 170,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColor.primary,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38,
                    blurRadius: 4,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: -2,
                    child: GestureDetector(
                      onTap: () {
                        print("fav");
                      },
                      child: Icon(Icons.favorite_border_outlined, size: 30),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Material(
                        elevation: 3,
                        borderRadius: BorderRadius.circular(50),
                        child:
                            state.music[0].poster == null
                                ? CircleAvatar(
                                  maxRadius: 50,
                                  backgroundColor: AppColor.secondary,
                                  child: Center(
                                    child: CircleAvatar(
                                      maxRadius: 15,
                                      backgroundImage: AssetImage(
                                        "assets/images/music.png",
                                      ),
                                    ),
                                  ),
                                )
                                : CircleAvatar(
                                  maxRadius: 50,
                                  backgroundColor: AppColor.secondary,
                                  backgroundImage: NetworkImage(
                                    state.music[0].poster.toString(),
                                  ),
                                  child: Center(
                                    child: CircleAvatar(
                                      maxRadius: 15,
                                      backgroundImage: AssetImage(
                                        "assets/images/music.png",
                                      ),
                                    ),
                                  ),
                                ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        height: 15,
                        child: Marquee(
                          text: state.music[0].title.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 12,
                          ),
                          scrollAxis: Axis.horizontal,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          blankSpace: 60.0,
                          velocity: 30.0,
                          startPadding: 10.0,
                          accelerationCurve: Curves.linear,
                          decelerationCurve: Curves.easeOut,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          state.music.length > 1
                              ? GestureDetector(
                                onTap: () {
                                  print("back");
                                },
                                child: Icon(
                                  Icons.skip_previous_rounded,
                                  size: 30,
                                ),
                              )
                              : SizedBox(),
                          GestureDetector(
                            onTap: () {
                              state.music[0].playing!
                                  ? audioPlayer.pause()
                                  : audioPlayer.play();

                              context.read<PlayingCubit>().playing(
                                state.music[0],
                              );
                            },
                            child: Icon(
                              state.music[0].playing!
                                  ? Icons.pause_rounded
                                  : Icons.play_arrow_rounded,
                              size: 30,
                            ),
                          ),
                          state.music.length > 1
                              ? GestureDetector(
                                onTap: () {
                                  print("next");
                                },
                                child: Icon(Icons.skip_next_rounded, size: 30),
                              )
                              : SizedBox(),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      } else if (state is MuicPlayingPlaylistNowState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Music Playing', style: TextStyle(fontSize: 16)),
            SizedBox(height: 15),
            Container(
              width: 170,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColor.primary,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38,
                    blurRadius: 4,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: -2,
                    child: Icon(Icons.playlist_add_rounded, size: 30),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Material(
                        elevation: 3,
                        borderRadius: BorderRadius.circular(50),
                        child: CircleAvatar(
                          maxRadius: 50,
                          backgroundColor: AppColor.secondary,
                          child: Center(
                            child: CircleAvatar(
                              maxRadius: 15,
                              backgroundImage: AssetImage(
                                "assets/images/music.png",
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "${state.playlist.listMusic![state.index].title}",
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              if (state.index > 0) {
                                context.read<PlayingCubit>().playingPlaylist(
                                  state.playlist,
                                  state.index - 1,
                                );
                              }
                              await audioPlayer.seekToPrevious();
                            },
                            child: Icon(Icons.skip_previous_rounded, size: 30),
                          ),
                          GestureDetector(
                            onTap: () async {
                              final musicPlaylist = ConcatenatingAudioSource(
                                children:
                                    state.playlist.listMusic!
                                        .map(
                                          (e) => AudioSource.uri(
                                            Uri.parse(e.data.toString()),
                                            tag: MediaItem(
                                              id: e.id.toString(),
                                              title: e.title.toString(),
                                              artist: e.artist.toString(),
                                              artUri: Uri.parse(
                                                e.poster.toString(),
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                              );

                              await audioPlayer.setAudioSource(
                                musicPlaylist,
                                initialIndex: state.index,
                                initialPosition: Duration.zero,
                              );
                              await audioPlayer.play();
                              audioPlayer.playerStateStream.listen((mState) {
                                print(mState.processingState);
                              });
                            },
                            child: Icon(Icons.play_arrow_rounded, size: 30),
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (state.index <
                                  state.playlist.listMusic!.length - 1) {
                                context.read<PlayingCubit>().playingPlaylist(
                                  state.playlist,
                                  state.index + 1,
                                );
                                print(state.index);
                              }
                              await audioPlayer.seekToNext();
                            },
                            child: Icon(Icons.skip_next_rounded, size: 30),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Music Playing', style: TextStyle(fontSize: 16)),
          SizedBox(height: 15),
          Container(
            width: 170,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColor.primary,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                  blurRadius: 4,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Stack(
              children: [
                Positioned(
                  right: -2,
                  child: Icon(Icons.playlist_add_rounded, size: 30),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Material(
                      elevation: 3,
                      borderRadius: BorderRadius.circular(50),
                      child: CircleAvatar(
                        maxRadius: 50,
                        backgroundColor: AppColor.secondary,
                        child: Center(
                          child: CircleAvatar(
                            maxRadius: 15,
                            backgroundImage: AssetImage(
                              "assets/images/music.png",
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text('No Music Playing', style: TextStyle(fontSize: 12)),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.skip_previous_rounded, size: 30),
                        Icon(Icons.play_arrow_rounded, size: 30),
                        Icon(Icons.skip_next_rounded, size: 30),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}
