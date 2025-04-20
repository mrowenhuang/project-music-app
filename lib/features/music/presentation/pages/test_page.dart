import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music_app/features/music/data/datasources/remote/music_remote_datasource.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await MusicRemoteDatasourceImpl().getPlaylist();
          },
          child: Text("data"),
        ),
      ),
    );
  }
}
