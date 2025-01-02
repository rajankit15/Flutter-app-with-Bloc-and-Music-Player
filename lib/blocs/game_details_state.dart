import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship_project/blocs/game_events.dart';
import 'package:internship_project/data/game_data.dart';
import 'package:internship_project/data/model/game_model.dart';

abstract class GameDetailsState {}

class GameDetailsLoadingState extends GameDetailsState {}

class GameDetailsLoadedState extends GameDetailsState {
  final Game game;
  GameDetailsLoadedState({required this.game});
}

class GameDetailsErrorState extends GameDetailsState {
  final String error;
  GameDetailsErrorState({required this.error});
}

class GameDetailsBloc extends Bloc<FetchGameDetailsEvent, GameDetailsState> {
  GameDetailsBloc() : super(GameDetailsLoadingState()) {
    on<GameDetailsEvent>((event, emit) async {
      emit(GameDetailsLoadingState());
      try {
        final Game game = await fetchGameDetails(event.gameId);
        emit(GameDetailsLoadedState(game: game));
      } catch (e) {
        emit(GameDetailsErrorState(error: e.toString()));
      }
    });
  }
}
