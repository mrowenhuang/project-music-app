import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_music_app/common/playing/cubit/playing_cubit.dart';
import 'package:flutter_music_app/core/configs/app_color.dart';
import 'package:flutter_music_app/features/music/data/models/music_models.dart';
import 'package:flutter_music_app/features/music/domain/entities/music_entites.dart';
import 'package:flutter_music_app/features/music/presentation/bloc/playlist_bloc/playlist_bloc.dart';
import 'package:just_audio/just_audio.dart';

Future playlistBottomSheet(
  BuildContext context,
  MusicEntites? musicData,
  TextEditingController playlistNameC,
  bool? isHome,
  AudioPlayer audioPlayer,
) {
  return showModalBottomSheet(
    showDragHandle: true,
    backgroundColor: AppColor.secondary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),

    context: context,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                "Playlist",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Add Playlist",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(10),
                    child: TextField(
                      controller: playlistNameC,
                      cursorColor: AppColor.third,
                      decoration: InputDecoration(
                        hintText: "Playlist Name",
                        suffixIcon: Icon(
                          Icons.playlist_add_circle_rounded,
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
                ),
                SizedBox(width: 10),
                BlocListener<PlaylistBloc, PlaylistState>(
                  bloc: context.read<PlaylistBloc>(),
                  listener: (context, state) {
                    if (state is SuccesAddPlaylistState) {
                      Flushbar(
                        message: state.message,
                        duration: const Duration(seconds: 2),
                        backgroundColor: Colors.green,
                        margin: const EdgeInsets.all(8),
                        borderRadius: BorderRadius.circular(10),
                        flushbarPosition: FlushbarPosition.TOP,
                        icon: const Icon(
                          Icons.error_outline,
                          color: Colors.white,
                        ),
                      ).show(context);
                    } else if (state is FailedAddPlaylistState) {
                      Flushbar(
                        message: state.failure,
                        duration: const Duration(seconds: 2),
                        backgroundColor: Colors.red,
                        margin: const EdgeInsets.all(8),
                        borderRadius: BorderRadius.circular(10),
                        flushbarPosition: FlushbarPosition.TOP,
                        icon: const Icon(
                          Icons.error_outline,
                          color: Colors.white,
                        ),
                      ).show(context);
                    }
                  },
                  child: ElevatedButton(
                    onPressed: () {
                      if (playlistNameC.text.trim().isEmpty) {
                        Flushbar(
                          message: "Please Input Playlist Name",
                          duration: const Duration(seconds: 2),
                          backgroundColor: Colors.red,
                          margin: const EdgeInsets.all(8),
                          borderRadius: BorderRadius.circular(10),
                          flushbarPosition: FlushbarPosition.TOP,
                          icon: const Icon(
                            Icons.error_outline,
                            color: Colors.white,
                          ),
                        ).show(context);
                      } else {
                        context.read<PlaylistBloc>().add(
                          AddPlaylistEvent(playlistName: playlistNameC.text),
                        );
                        playlistNameC.clear();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.third,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text("Add Playlist"),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              "Playlist Created",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: BlocConsumer<PlaylistBloc, PlaylistState>(
                listener: (context, state) {
                  if (state is SuccesDeletePlaylistState) {
                    Flushbar(
                      message: "Success Delete Playlist",
                      duration: const Duration(seconds: 2),
                      backgroundColor: Colors.green,
                      margin: const EdgeInsets.all(8),
                      borderRadius: BorderRadius.circular(10),
                      flushbarPosition: FlushbarPosition.TOP,
                      icon: const Icon(
                        Icons.error_outline,
                        color: Colors.white,
                      ),
                    ).show(context);
                  } else if (state is SuccesAddMusicToPlaylistState) {
                    Flushbar(
                      message: "Success Add Music to Playlist",
                      duration: const Duration(seconds: 2),
                      backgroundColor: Colors.green,
                      margin: const EdgeInsets.all(8),
                      borderRadius: BorderRadius.circular(10),
                      flushbarPosition: FlushbarPosition.TOP,
                      icon: const Icon(
                        Icons.error_outline,
                        color: Colors.white,
                      ),
                    ).show(context);
                  }
                },
                bloc: context.read<PlaylistBloc>(),
                builder: (context, state) {
                  if (state is LoadingPlaylistState) {
                    return Center(child: CupertinoActivityIndicator());
                  } else if (state is SuccesGetPlaylistState) {
                    return state.palylist.isEmpty
                        ? Center(child: Text("No Playlist Created"))
                        : GridView.builder(
                          physics: BouncingScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                mainAxisExtent: 50,
                              ),
                          itemCount: state.palylist.length,
                          itemBuilder: (context, index) {
                            final data = state.palylist[index];

                            return GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  showDragHandle: true,

                                  backgroundColor: AppColor.secondary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                  ),
                                  context: context,
                                  builder: (context) {
                                    return Padding(
                                      padding: EdgeInsets.all(20),
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              data.playlistName.toString(),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              ElevatedButton.icon(
                                                onPressed: () {
                                                  context
                                                      .read<PlaylistBloc>()
                                                      .add(
                                                        DeletePlaylistEvent(
                                                          id:
                                                              data.id
                                                                  .toString(),
                                                        ),
                                                      );
                                                  Navigator.pop(context);
                                                },
                                                icon: Icon(Icons.delete),
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.red,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          10,
                                                        ),
                                                  ),
                                                ),
                                                label: Text(
                                                  "Delete",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              isHome == true
                                                  ? SizedBox()
                                                  : ElevatedButton.icon(
                                                    onPressed: () {
                                                      context.read<PlaylistBloc>().add(
                                                        AddMusicToPlaylistEvent(
                                                          id:
                                                              data.id
                                                                  .toString(),
                                                          music:
                                                              musicData
                                                                  as MusicModels,
                                                        ),
                                                      );
                                                      Navigator.pop(context);
                                                    },
                                                    icon: Icon(Icons.add),
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor:
                                                          Colors.green,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              10,
                                                            ),
                                                      ),
                                                    ),
                                                    label: Text(
                                                      "Add Music",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                              ElevatedButton.icon(
                                                onPressed: () async {
                                                  context
                                                      .read<PlayingCubit>()
                                                      .playingPlaylist(
                                                        data,
                                                        0,
                                                      );
                                                },
                                                icon: Icon(
                                                  Icons.play_arrow_rounded,
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      AppColor.third,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          10,
                                                        ),
                                                  ),
                                                ),
                                                label: Text(
                                                  "Play",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),

                                          // ! masalah di sini di add data tidak di refresh
                                          Expanded(
                                            child:
                                                data.listMusic!.isEmpty
                                                    ? Center(
                                                      child: Text("No Music"),
                                                    )
                                                    : ListView.builder(
                                                      physics:
                                                          BouncingScrollPhysics(),
                                                      itemCount:
                                                          data
                                                              .listMusic!
                                                              .length,

                                                      itemBuilder: (
                                                        context,
                                                        index,
                                                      ) {
                                                        final value =
                                                            data.listMusic![index];

                                                        if (state
                                                            is LoadingPlaylistState) {
                                                          print(
                                                            "loading dari listtile",
                                                          );
                                                        }
                                                        return ListTile(
                                                          title: Text(
                                                            value.title
                                                                .toString(),
                                                          ),
                                                          subtitle: Text(
                                                            value.artist
                                                                .toString(),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: AppColor.primary,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black45,
                                      blurRadius: 4,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                                alignment: Alignment.center,

                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        data.playlistName.toString(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Icon(Icons.playlist_play_rounded),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                  }
                  return Center(child: Text("Something was wrong"));
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}
