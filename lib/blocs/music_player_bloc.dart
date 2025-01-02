import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship_project/blocs/music_event.dart';
import 'package:internship_project/blocs/music_state.dart';
import 'package:just_audio/just_audio.dart';

class MusicPlayerBloc extends Bloc<MusicPlayerEvent, MusicPlayerState> {
  final AudioPlayer _audioPlayer;

  AudioPlayer get audioPlayer => _audioPlayer;

  MusicPlayerBloc()
      : _audioPlayer = AudioPlayer(),
        super(MusicPlayerState()) {
    on<LoadMusic>((event, emit) async {
      emit(state.copyWith(
          audioPaths: event.audioPaths,
          currentIndex: event.currentIndex,
          isPlaying: true));
      await _audioPlayer.setAudioSource(
        ConcatenatingAudioSource(
          children:
              event.audioPaths.map((path) => AudioSource.asset(path)).toList(),
        ),
        initialIndex: event.currentIndex,
      );
      await _audioPlayer.play();
    });

    on<PlayMusic>((event, emit) async {
      print('playing');
      await _audioPlayer.play();
      emit(state.copyWith(isPlaying: true));
    });

    on<PauseMusic>((event, emit) async {
      print('pausing');
      await _audioPlayer.pause();
      emit(state.copyWith(isPlaying: false));
    });

    on<NextMusic>((event, emit) async {
      final nextIndex = (state.currentIndex + 1) % state.audioPaths.length;
      await _audioPlayer
          .setAudioSource(AudioSource.asset(state.audioPaths[nextIndex]));
      await _audioPlayer.play();
      emit(state.copyWith(currentIndex: nextIndex));
    });

    on<PreviousMusic>((event, emit) async {
      final previousIndex = (state.currentIndex - 1) < 0
          ? state.audioPaths.length - 1
          : state.currentIndex - 1;
      await _audioPlayer
          .setAudioSource(AudioSource.asset(state.audioPaths[previousIndex]));
      await _audioPlayer.play();
      emit(state.copyWith(currentIndex: previousIndex));
    });

    _audioPlayer.positionStream.listen((position) {
      add(UpdateProgress(position, _audioPlayer.duration ?? Duration.zero));
    });

    on<UpdateProgress>((event, emit) {
      emit(state.copyWith(
        position: event.position,
        duration: event.duration,
      ));
    });
  }
}
