abstract class MusicPlayerEvent {
  List<Object?> get props => [];
}

class LoadMusic extends MusicPlayerEvent {
  final List<String> audioPaths;
  final int currentIndex;

  LoadMusic(this.audioPaths, this.currentIndex);
}

class PlayMusic extends MusicPlayerEvent {}

class PauseMusic extends MusicPlayerEvent {}

class NextMusic extends MusicPlayerEvent {}

class PreviousMusic extends MusicPlayerEvent {}

class UpdateProgress extends MusicPlayerEvent {
  final Duration position;
  final Duration duration;

  UpdateProgress(this.position, this.duration);
}
