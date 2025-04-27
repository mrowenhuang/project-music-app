import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_music_app/common/playing/cubit/playing_cubit.dart';
import 'package:flutter_music_app/core/configs/app_color.dart';
import 'package:just_audio/just_audio.dart';
import 'package:marquee/marquee.dart';

Widget musicPlayingFloating(BuildContext context, AudioPlayer audioPlayer) {
  return Positioned(
    bottom: 0,
    right: 0,
    left: 0,
    child: Container(
      padding: EdgeInsets.all(10),
      width: double.infinity,
      height: 80,
      decoration: BoxDecoration(
        color: AppColor.primary,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Colors.black38, blurRadius: 4, offset: Offset(0, 4)),
        ],
      ),
      child: BlocBuilder<PlayingCubit, PlayingState>(
        bloc: context.read<PlayingCubit>(),
        builder: (context, state) {
          if (state is MusicPlayingNowState) {
            return Row(
              children: [
                Material(
                  elevation: 3,
                  borderRadius: BorderRadius.circular(50),
                  child:
                      state.music[0].poster == null
                          ? CircleAvatar(
                            maxRadius: 30,
                            backgroundColor: AppColor.secondary,
                            child: Center(
                              child: CircleAvatar(
                                maxRadius: 10,
                                backgroundImage: AssetImage(
                                  "assets/images/music.png",
                                ),
                              ),
                            ),
                          )
                          : CircleAvatar(
                            maxRadius: 30,
                            backgroundColor: AppColor.secondary,
                            backgroundImage: NetworkImage(
                              state.music[0].poster.toString(),
                            ),
                            child: Center(
                              child: CircleAvatar(
                                maxRadius: 10,
                                backgroundImage: AssetImage(
                                  "assets/images/music.png",
                                ),
                              ),
                            ),
                          ),
                ),
                SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 100,
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
                    SizedBox(height: 5),
                    Text(
                      state.music[0].artist!,
                      style: TextStyle(fontSize: 10, color: Colors.black45),
                    ),
                  ],
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    context.read<PlayingCubit>().playing(state.music[0]);
                  },
                  child: Icon(
                    state.music[0].playing!
                        ? Icons.pause_rounded
                        : Icons.play_arrow_rounded,
                    size: 30,
                  ),
                ),
                Spacer(),
              ],
            );
          } else if (state is MusicPlayingPlaylistNowState) {
            return Row(
              children: [
                Material(
                  elevation: 3,
                  borderRadius: BorderRadius.circular(50),
                  child:
                      state.playlist.listMusic![state.index].poster == null
                          ? CircleAvatar(
                            maxRadius: 30,
                            backgroundColor: AppColor.secondary,
                            child: Center(
                              child: CircleAvatar(
                                maxRadius: 10,
                                backgroundImage: AssetImage(
                                  "assets/images/music.png",
                                ),
                              ),
                            ),
                          )
                          : CircleAvatar(
                            maxRadius: 30,
                            backgroundColor: AppColor.secondary,
                            backgroundImage: NetworkImage(
                              state.playlist.listMusic![state.index].poster
                                  .toString(),
                            ),
                            child: Center(
                              child: CircleAvatar(
                                maxRadius: 10,
                                backgroundImage: AssetImage(
                                  "assets/images/music.png",
                                ),
                              ),
                            ),
                          ),
                ),
                SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 100,
                      height: 15,
                      child: Marquee(
                        text:
                            state.playlist.listMusic![state.index].title
                                .toString(),
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
                    SizedBox(height: 5),
                    Text(
                      state.playlist.listMusic![state.index].artist.toString(),
                      style: TextStyle(fontSize: 10, color: Colors.black45),
                    ),
                  ],
                ),
                Spacer(),
                GestureDetector(
                  onTap: () async {
                    context.read<PlayingCubit>().prevSong();
                  },
                  child: Icon(Icons.skip_previous_rounded, size: 40),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () async {
                    context.read<PlayingCubit>().togglePlayMusic();
                  },
                  child: Icon(
                    state.playlist.listMusic![state.index].playing!
                        ? Icons.pause_rounded
                        : Icons.play_arrow_rounded,
                    size: 30,
                  ),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    context.read<PlayingCubit>().nextSong();
                  },
                  child: Icon(Icons.skip_next_rounded, size: 40),
                ),
                Spacer(),
              ],
            );
          }
          return Row(
            children: [
              Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(50),
                child: CircleAvatar(
                  maxRadius: 30,
                  backgroundColor: AppColor.secondary,

                  child: Center(
                    child: CircleAvatar(
                      maxRadius: 10,
                      backgroundImage: AssetImage("assets/images/music.png"),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('No Music Playing', style: TextStyle(fontSize: 12)),
                  SizedBox(height: 5),
                ],
              ),
            ],
          );
        },
      ),
    ),
  );
}
