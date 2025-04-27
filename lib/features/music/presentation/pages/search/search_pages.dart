import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_music_app/common/playing/cubit/playing_cubit.dart';
import 'package:flutter_music_app/common/switch/cubit/switch_cubit.dart';
import 'package:flutter_music_app/core/configs/app_color.dart';
import 'package:flutter_music_app/features/music/presentation/bloc/music_bloc.dart';
import 'package:flutter_music_app/features/music/presentation/bloc/search_bloc/search_bloc.dart';

class SearchPages extends StatelessWidget {
  const SearchPages({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchC = TextEditingController();

    return Scaffold(
      backgroundColor: AppColor.secondary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          splashRadius: 1,
          icon: Icon(Icons.arrow_back_rounded, color: AppColor.third),
        ),
        title: Text('Search Song', style: TextStyle(color: AppColor.third)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
        child: BlocBuilder<SwitchCubit, bool>(
          bloc: context.read<SwitchCubit>(),
          builder: (context, state) {
            return Column(
              children: [
                Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(10),
                  child: TextField(
                    controller: searchC,
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
                    onSubmitted: (value) {
                      context.read<SearchBloc>().add(
                        GetSearchMusicEvent(text: value, type: state),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CupertinoSwitch(
                      value: state,
                      activeTrackColor: AppColor.third,
                      thumbColor: AppColor.primary,
                      onChanged: (value) {
                        context.read<SwitchCubit>().toggleSwitch(value);
                      },
                    ),
                    Text(
                      state ? "Online" : "Ofline",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                BlocBuilder<SearchBloc, SearchState>(
                  bloc: context.read<SearchBloc>(),
                  builder: (context, state) {
                    if (state is LoadingGetMusicState) {
                      return Expanded(
                        child: Center(child: CupertinoActivityIndicator()),
                      );
                    } else if (state is SuccessGetSearchMusicState) {
                      return Expanded(
                        child:
                            state.music.isEmpty
                                ? Center(
                                  child: Text("No found ${searchC.text}"),
                                )
                                : ListView.builder(
                                  itemCount: state.music.length,
                                  itemBuilder: (context, index) {
                                    final data = state.music[index];
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 10,
                                      ),
                                      child: ListTile(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        tileColor: AppColor.primary,
                                        title: Text(
                                          data.title.toString(),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        subtitle: Text(data.artist.toString()),
                                        trailing: ElevatedButton.icon(
                                          onPressed: () {
                                            context
                                                .read<PlayingCubit>()
                                                .playing(data);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColor.third,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          label: Text("play"),
                                          icon: Icon(Icons.play_arrow_rounded),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                      );
                    }
                    return Expanded(
                      child: Center(child: Text("No Search Music")),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
