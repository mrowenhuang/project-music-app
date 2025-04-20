import 'package:flutter/material.dart';
import 'package:flutter_music_app/features/music/presentation/pages/cont.dart';

class HomePages2 extends StatefulWidget {
  const HomePages2({super.key});

  @override
  State<HomePages2> createState() => _HomePages2State();
}

class _HomePages2State extends State<HomePages2> {
  final TextEditingController artistC = TextEditingController();
  final TextEditingController posterC = TextEditingController();
  final TextEditingController urlC = TextEditingController();
  final TextEditingController titleC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: artistC,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'artist',
              ),
            ),
            TextField(
              controller: posterC,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'poster',
              ),
            ),
            TextField(
              controller: urlC,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "data",
              ),
            ),
            TextField(
              controller: titleC,

              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Title",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Cont().addData(
                  titleC.text,
                  urlC.text,
                  posterC.text,
                  artistC.text,
                );
                titleC.clear();
                urlC.clear();
                posterC.clear();
                artistC.clear();
              },
              child: Text("push"),
            ),
          ],
        ),
      ),
    );
  }
}
