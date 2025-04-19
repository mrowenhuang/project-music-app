import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_music_app/common/playing/cubit/playing_cubit.dart';
import 'package:flutter_music_app/core/configs/app_color.dart';
import 'package:flutter_music_app/features/music/presentation/bloc/music_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

class HomePages extends StatelessWidget {
  const HomePages({super.key});

  @override
  Widget build(BuildContext context) {
    final AudioPlayer _audioPlayer = AudioPlayer();
    int? _playingSongId;

    return Scaffold(
      backgroundColor: AppColor.secondary,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Stack(
          children: [
            Column(
              children: [
                Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(10),
                  child: TextField(
                    cursorColor: AppColor.third,
                    decoration: InputDecoration(
                      hintText: "Search",
                      suffixIcon: Icon(
                        Icons.search,
                        color: AppColor.third,
                        size: 30,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocBuilder<PlayingCubit, PlayingState>(
                      bloc: context.read<PlayingCubit>(),
                      builder: (context, state) {
                        if (state is MusicPlayingNowState) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Music Playing',
                                style: TextStyle(fontSize: 16),
                              ),
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
                                        child: Icon(
                                          Icons.favorite_border_outlined,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Material(
                                          elevation: 3,
                                          borderRadius: BorderRadius.circular(
                                            50,
                                          ),
                                          child: CircleAvatar(
                                            maxRadius: 50,
                                            backgroundColor: AppColor.secondary,
                                            backgroundImage: NetworkImage(
                                              state.music[0].poster.toString(),
                                            ),
                                            child: Center(
                                              child: CircleAvatar(
                                                maxRadius: 15,
                                                backgroundColor: AppColor.third,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          state.music[0].title.toString(),
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
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
                                                    ? _audioPlayer.pause()
                                                    : _audioPlayer.play();

                                                context
                                                    .read<PlayingCubit>()
                                                    .playing(state.music[0]);
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
                                                  child: Icon(
                                                    Icons.skip_next_rounded,
                                                    size: 30,
                                                  ),
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
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Music Playing',
                              style: TextStyle(fontSize: 16),
                            ),
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
                                    child: Icon(
                                      Icons.favorite_border_outlined,
                                      size: 30,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                              backgroundColor: AppColor.third,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'No Music Playing',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Icon(
                                            Icons.skip_previous_rounded,
                                            size: 30,
                                          ),
                                          Icon(
                                            Icons.play_arrow_rounded,
                                            size: 30,
                                          ),
                                          Icon(
                                            Icons.skip_next_rounded,
                                            size: 30,
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
                      },
                    ),
                    SizedBox(width: 18),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Playlist Music', style: TextStyle(fontSize: 16)),
                        SizedBox(height: 15),

                        SizedBox(
                          width: 160,
                          height: 200,
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: 3,
                            physics: BouncingScrollPhysics(),

                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  height: 50,
                                  width: 180,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
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
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
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
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.screen_rotation_alt_outlined),
                    label: Text(
                      "My Music",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      context.read<MusicBloc>().add(GetOfflineMusicEvent());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.third,

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text("Online", style: TextStyle(fontSize: 16)),
                    SizedBox(width: 10),
                    Icon(Icons.screen_rotation_alt_outlined),
                  ],
                ),
                SizedBox(height: 15),
                Expanded(
                  child: BlocBuilder<PlayingCubit, PlayingState>(
                    bloc: context.read<PlayingCubit>(),
                    builder: (context, pstate) {
                      return BlocBuilder<MusicBloc, MusicState>(
                        bloc: context.read<MusicBloc>(),
                        builder: (context, state) {
                          if (state is LoadingGetOnlineMusicState) {
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
                                return Container(
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: AppColor.primary,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      Material(
                                        elevation: 8,
                                        borderRadius: BorderRadius.circular(
                                          100,
                                        ),
                                        child: CircleAvatar(
                                          maxRadius: 60,
                                          backgroundColor: AppColor.secondary,
                                          backgroundImage: NetworkImage(
                                            data.poster.toString(),
                                          ),
                                          child: Center(
                                            child: CircleAvatar(
                                              maxRadius: 15,
                                              backgroundColor: AppColor.third,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 100,
                                                child: Text(
                                                  data.title.toString(),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),

                                              Text(
                                                data.artist.toString(),
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.black45,
                                                ),
                                              ),
                                            ],
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              if (data.playing == true) {
                                                context
                                                    .read<PlayingCubit>()
                                                    .playing(data);
                                                _audioPlayer.pause();
                                              } else if (data.playing == null) {
                                                context
                                                    .read<PlayingCubit>()
                                                    .playing(data);
                                                _audioPlayer.setAudioSource(
                                                  AudioSource.uri(
                                                    Uri.parse(
                                                      data.url.toString(),
                                                    ),
                                                    tag: MediaItem(
                                                      id: data.title.toString(),
                                                      title:
                                                          data.title.toString(),
                                                      artist: data.artist,
                                                      artUri: Uri.parse(
                                                        data.poster.toString(),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                                _audioPlayer.play();
                                              } else {
                                                context
                                                    .read<PlayingCubit>()
                                                    .playing(data);
                                                _audioPlayer.play();
                                              }
                                            },
                                            child: CircleAvatar(
                                              backgroundColor: AppColor.third,
                                              maxRadius: 20,
                                              child: Center(
                                                child: Icon(
                                                  data.playing == null
                                                      ? Icons.play_arrow_rounded
                                                      : data.playing == false
                                                      ? Icons.play_arrow_rounded
                                                      : Icons.pause_rounded,

                                                  color: AppColor.secondary,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
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
            Positioned(
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
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: 4,
                      offset: Offset(0, 4),
                    ),
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
                            child: CircleAvatar(
                              maxRadius: 30,
                              backgroundColor: AppColor.secondary,
                              backgroundImage: NetworkImage(
                                state.music[0].poster!,
                              ),
                              child: Center(
                                child: CircleAvatar(
                                  maxRadius: 10,
                                  backgroundColor: AppColor.third,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                state.music[0].title!,
                                style: TextStyle(fontSize: 12),
                              ),
                              SizedBox(height: 5),
                              Text(
                                state.music[0].artist!,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.black45,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              print("shiffel");
                            },
                            child: Icon(Icons.shuffle, size: 30),
                          ),
                          SizedBox(width: 10),

                          GestureDetector(
                            onTap: () {
                              print("back");
                            },
                            child: Icon(Icons.skip_previous_rounded, size: 40),
                          ),
                          SizedBox(width: 10),

                          GestureDetector(
                            onTap: () {
                              print("play");
                            },
                            child: Icon(Icons.play_arrow_rounded, size: 40),
                          ),
                          SizedBox(width: 10),

                          GestureDetector(
                            onTap: () {
                              print("next");
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
                            backgroundImage: NetworkImage(
                              'https://picsum.photos/id/130/200/300',
                            ),
                            child: Center(
                              child: CircleAvatar(
                                maxRadius: 10,
                                backgroundColor: AppColor.third,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Music Title', style: TextStyle(fontSize: 12)),
                            SizedBox(height: 5),
                            Text(
                              'Actrees',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.black45,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            print("shiffel");
                          },
                          child: Icon(Icons.shuffle, size: 30),
                        ),
                        SizedBox(width: 10),

                        GestureDetector(
                          onTap: () {
                            print("back");
                          },
                          child: Icon(Icons.skip_previous_rounded, size: 40),
                        ),
                        SizedBox(width: 10),

                        GestureDetector(
                          onTap: () {
                            print("play");
                          },
                          child: Icon(Icons.play_arrow_rounded, size: 40),
                        ),
                        SizedBox(width: 10),

                        GestureDetector(
                          onTap: () {
                            print("next");
                          },
                          child: Icon(Icons.skip_next_rounded, size: 40),
                        ),

                        Spacer(),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
