import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_music_app/common/playing/cubit/playing_cubit.dart';
import 'package:flutter_music_app/core/configs/app_color.dart';
import 'package:flutter_music_app/features/music/domain/entities/music_entites.dart';
import 'package:flutter_music_app/features/music/presentation/widgets/playlist_bottom_sheet.dart';
import 'package:just_audio/just_audio.dart';

Widget musicBox(
  BuildContext context,
  AudioPlayer audioPlayer,
  MusicEntites musicData,
  TextEditingController playlistNameC,
) {
  return Container(
    padding: EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: AppColor.primary,
      borderRadius: BorderRadius.circular(15),
    ),
    alignment: Alignment.center,
    child: Stack(
      children: [
        Positioned(
          right: -2,
          child: GestureDetector(
            onTap: () {
              playlistBottomSheet(
                context,
                musicData,
                playlistNameC,
                false,
                audioPlayer,
              );
            },
            child: Icon(Icons.playlist_add_rounded, size: 30),
          ),
        ),
        Column(
          children: [
            Material(
              elevation: 8,
              borderRadius: BorderRadius.circular(100),
              child:
                  musicData.poster == null
                      ? CircleAvatar(
                        maxRadius: 60,
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
                        maxRadius: 60,
                        backgroundColor: AppColor.secondary,
                        backgroundImage: NetworkImage(
                          musicData.poster.toString(),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 100,
                      child: Text(
                        musicData.title.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    Text(
                      musicData.artist.toString(),
                      style: TextStyle(fontSize: 10, color: Colors.black45),
                    ),
                  ],
                ),
                BlocBuilder<PlayingCubit, PlayingState>(
                  bloc: context.read<PlayingCubit>(),
                  builder: (context, state) {
                    if (state is MusicPlayingNowState) {
                      return GestureDetector(
                        onTap: () {
                          context.read<PlayingCubit>().playing(musicData);
                        },
                        child: CircleAvatar(
                          backgroundColor: AppColor.third,
                          maxRadius: 20,
                          child: Center(
                            child: Icon(
                              state.music[0].title == musicData.title &&
                                      state.music[0].playing == true
                                  ? Icons.pause_rounded
                                  : Icons.play_arrow_rounded,

                              color: AppColor.secondary,
                            ),
                          ),
                        ),
                      );
                    }
                    return GestureDetector(
                      onTap: () {
                        context.read<PlayingCubit>().playing(musicData);
                      },
                      child: CircleAvatar(
                        backgroundColor: AppColor.third,
                        maxRadius: 20,
                        child: Center(
                          child: Icon(
                            musicData.playing == true
                                ? Icons.pause_rounded
                                : Icons.play_arrow_rounded,

                            color: AppColor.secondary,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}
