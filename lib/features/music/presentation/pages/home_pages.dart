import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_music_app/common/playing/cubit/playing_cubit.dart';
import 'package:flutter_music_app/core/configs/app_color.dart';
import 'package:flutter_music_app/core/navigation/app_navigation.dart';
import 'package:flutter_music_app/features/music/presentation/bloc/music_bloc.dart';
import 'package:flutter_music_app/features/music/presentation/pages/search/search_pages.dart';
import 'package:flutter_music_app/features/music/presentation/widgets/music_box.dart';
import 'package:flutter_music_app/features/music/presentation/widgets/music_playing_box.dart';
import 'package:flutter_music_app/features/music/presentation/widgets/music_playing_flaoting.dart';
import 'package:flutter_music_app/features/music/presentation/widgets/playlist_bottom_sheet.dart';
import 'package:flutter_music_app/injection.dart';
import 'package:just_audio/just_audio.dart';

class HomePages extends StatelessWidget {
  const HomePages({super.key});

  @override
  Widget build(BuildContext context) {
    final AudioPlayer audioPlayer = sl<AudioPlayer>();
    final TextEditingController playlistNameC = TextEditingController();
    return Scaffold(
      backgroundColor: AppColor.secondary,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    AppNavigation.push(context, SearchPages());
                  },
                  child: Container(
                    width: double.infinity,
                    height: 55,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColor.secondary,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4,
                          color: Colors.black45,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Search",
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        Icon(Icons.search, color: AppColor.third, size: 30),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    musicPlayingBox(context, audioPlayer, playlistNameC),
                    SizedBox(width: 14),
                    BlocBuilder<PlayingCubit, PlayingState>(
                      bloc: context.read<PlayingCubit>(),
                      builder: (context, state) {
                        if (state is MusicPlayingPlaylistNowState) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Playlist ${state.playlist.playlistName}',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(height: 15),
                              SizedBox(
                                width: 160,
                                height: 200,
                                child: ListView.builder(
                                  padding: EdgeInsets.only(
                                    top: 0,
                                    left: 4,
                                    right: 4,
                                  ),
                                  itemCount: state.playlist.listMusic!.length,
                                  physics: BouncingScrollPhysics(),

                                  itemBuilder: (context, index) {
                                    final data =
                                        state.playlist.listMusic![index];
                                    return Padding(
                                      padding: EdgeInsets.only(bottom: 10),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10,
                                        ),
                                        height: 50,
                                        width: 180,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          color: AppColor.secondary,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black38,
                                              offset: Offset(0, 4),
                                              blurRadius: 4,
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                data.title.toString(),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ),
                                            Text(
                                              (index + 1).toString(),
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        }
                        return Text(
                          'No Playlist Playing',
                          style: TextStyle(fontSize: 16),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton.icon(
                      icon: Icon(Icons.playlist_play_rounded),
                      label: Text(
                        "Playlist",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        playlistBottomSheet(
                          context,
                          null,
                          playlistNameC,
                          true,
                          audioPlayer,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.third,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    BlocBuilder<MusicBloc, MusicState>(
                      builder: (context, state) {
                        return ElevatedButton.icon(
                          icon: Icon(Icons.screen_rotation_alt_outlined),
                          label: Text(
                            state is SuccesGetOnlineMusicState
                                ? "My Music"
                                : "Online",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            if (state is SuccesGetOnlineMusicState) {
                              context.read<MusicBloc>().add(
                                GetOfflineMusicEvent(),
                              );
                            } else if (state is SuccesGetOfflineMusicState) {
                              context.read<MusicBloc>().add(
                                GetOnlineMusicEvent(),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.third,

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                BlocBuilder<MusicBloc, MusicState>(
                  builder: (context, state) {
                    return Row(
                      children: [
                        Text(
                          state is SuccesGetOnlineMusicState
                              ? "Online"
                              : "My Music",
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(width: 10),
                        Icon(Icons.screen_rotation_alt_outlined),
                      ],
                    );
                  },
                ),
                SizedBox(height: 15),
                Expanded(
                  child: BlocBuilder<PlayingCubit, PlayingState>(
                    bloc: context.read<PlayingCubit>(),
                    builder: (context, pstate) {
                      return BlocBuilder<MusicBloc, MusicState>(
                        bloc: context.read<MusicBloc>(),
                        builder: (context, state) {
                          if (state is LoadingGetMusicState) {
                            return Center(
                              child: CupertinoActivityIndicator(
                                color: AppColor.third,
                              ),
                            );
                          } else if (state is SuccesGetOnlineMusicState) {
                            return GridView.builder(
                              padding: EdgeInsets.only(top: 0, bottom: 100),
                              physics: BouncingScrollPhysics(),
                              itemCount: state.music.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    childAspectRatio: .85,
                                  ),
                              itemBuilder: (context, index) {
                                final data = state.music[index];
                                if (pstate is MusicPlayingNowState) {
                                  if (data.title != pstate.music[0].title) {
                                    data.playing = null;
                                  }
                                }
                                return musicBox(
                                  context,
                                  audioPlayer,
                                  data,
                                  playlistNameC,
                                );
                              },
                            );
                          } else if (state is SuccesGetOfflineMusicState) {
                            return GridView.builder(
                              padding: EdgeInsets.only(top: 0, bottom: 100),
                              physics: BouncingScrollPhysics(),
                              itemCount: state.music.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    childAspectRatio: .85,
                                  ),
                              itemBuilder: (context, index) {
                                final data = state.music[index];
                                if (pstate is MusicPlayingNowState) {
                                  if (data.title != pstate.music[0].title) {
                                    data.playing = null;
                                  }
                                }
                                return musicBox(
                                  context,
                                  audioPlayer,
                                  data,
                                  playlistNameC,
                                );
                              },
                            );
                          } else if (state is FailedGetOnlineMusicState) {
                            return Center(child: Text(state.failure));
                          }
                          return SizedBox();
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            musicPlayingFloating(context, audioPlayer),
          ],
        ),
      ),
    );
  }
}
