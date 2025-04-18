import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class MusicEntites extends Equatable {
  String? title;
  String? artist;
  String? url;
  String? poster;
  bool? playing;
  MusicEntites({this.title, this.artist, this.url, this.poster, this.playing});

  @override
  List<Object?> get props => [title, artist, url, poster, playing];
}
