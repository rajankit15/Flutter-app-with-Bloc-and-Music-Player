import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship_project/blocs/music_event.dart';
import 'package:internship_project/blocs/music_player_bloc.dart';
import 'package:internship_project/screens/music_player.dart';
import 'package:internship_project/widgets/music_card.dart';

class MusicScreen extends StatelessWidget {
  MusicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> audioFiles = [
      'assets/audio/sample1.mp3',
      'assets/audio/sample2.mp3',
      'assets/audio/sample3.mp3',
      'assets/audio/sample4.mp3',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Play Music',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: audioFiles.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: musicCard(
                audioFiles[index].replaceAll('.mp3', '').split('/').last,
                () {
                  BlocProvider.of<MusicPlayerBloc>(context)
                      .add(LoadMusic(audioFiles, index));
                  BlocProvider.of<MusicPlayerBloc>(context).add(PlayMusic());
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) {
                      return BlocProvider.value(
                        value: BlocProvider.of<MusicPlayerBloc>(context),
                        child: MusicPlayerScreen(),
                      );
                    }),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
