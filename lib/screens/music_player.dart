import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship_project/blocs/music_event.dart';
import 'package:internship_project/blocs/music_player_bloc.dart';
import 'package:internship_project/blocs/music_state.dart';

class MusicPlayerScreen extends StatelessWidget {
  const MusicPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String _formatDuration(Duration duration) {
      final minutes =
          duration.inMinutes.remainder(60).toString().padLeft(2, '0');
      final seconds =
          duration.inSeconds.remainder(60).toString().padLeft(2, '0');
      return '$minutes:$seconds';
    }

    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<MusicPlayerBloc, MusicPlayerState>(
        builder: (context, state) {
          final currTrack = state.audioPaths.isNotEmpty
              ? state.audioPaths[state.currentIndex]
                  .replaceAll('.mp3', '')
                  .split('/')
                  .last
              : '';
          return Column(
            children: [
              const SizedBox(height: 16),
              const CircleAvatar(
                backgroundColor: Color.fromARGB(255, 143, 185, 219),
                radius: 120,
                child: Icon(
                  Icons.music_note,
                  color: Color.fromARGB(255, 21, 119, 218),
                  size: 48,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                currTrack,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Slider(
                value: state.position.inSeconds
                    .toDouble()
                    .clamp(0, state.duration.inSeconds.toDouble()),
                min: 0,
                max: state.duration.inSeconds.toDouble(),
                onChanged: (value) {
                  context
                      .read<MusicPlayerBloc>()
                      .audioPlayer
                      .seek(Duration(seconds: value.toInt()));
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  children: [
                    Text(
                      _formatDuration(state.position),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                    Spacer(),
                    Text(
                      _formatDuration(state.duration),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () =>
                        context.read<MusicPlayerBloc>().add(PreviousMusic()),
                    icon: Icon(Icons.skip_previous),
                    iconSize: 50,
                  ),
                  const SizedBox(width: 5),
                  CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 40,
                    child: GestureDetector(
                      onTap: () {
                        if (state.isPlaying) {
                          context.read<MusicPlayerBloc>().add(PauseMusic());
                        } else {
                          context.read<MusicPlayerBloc>().add(PlayMusic());
                        }
                      },
                      child: Icon(
                        state.isPlaying ? Icons.pause : Icons.play_arrow,
                        color: Colors.white,
                        size: 45,
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  IconButton(
                    onPressed: () =>
                        context.read<MusicPlayerBloc>().add(NextMusic()),
                    icon: Icon(Icons.skip_next),
                    iconSize: 50,
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
