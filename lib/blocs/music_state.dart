class MusicPlayerState {
  final int currentIndex;
  final Duration position;
  final Duration duration;
  final bool isPlaying;
  final List<String> audioPaths;

  MusicPlayerState({
    this.currentIndex = 0,
    this.position = Duration.zero,
    this.duration = Duration.zero,
    this.isPlaying = false,
    this.audioPaths = const [],
  });

  MusicPlayerState copyWith({
    int? currentIndex,
    Duration? position,
    Duration? duration,
    bool? isPlaying,
    List<String>? audioPaths,
  }) {
    return MusicPlayerState(
      currentIndex: currentIndex ?? this.currentIndex,
      position: position ?? this.position,
      duration: duration ?? this.duration,
      isPlaying: isPlaying ?? this.isPlaying,
      audioPaths: audioPaths ?? this.audioPaths,
    );
  }

  List<Object?> get props =>
      [currentIndex, position, duration, isPlaying, audioPaths];
}
