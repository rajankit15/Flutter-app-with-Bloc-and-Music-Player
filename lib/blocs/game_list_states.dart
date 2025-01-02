import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship_project/blocs/game_events.dart';
import 'package:internship_project/data/game_data.dart';
import 'package:internship_project/data/model/game_model.dart';

abstract class GameListState {}

class GameListInitialState extends GameListState {}

class GameListLoadingState extends GameListState {}

class GameListLoadedState extends GameListState {
  final List<Game> games;
  GameListLoadedState({required this.games});
  List<Object> get props => [games];
}

class GameListErrorState extends GameListState {
  final String error;
  GameListErrorState({required this.error});
  List<Object> get props => [error];
}

class GameListBloc extends Bloc<GameListEvent, GameListState> {
  GameListBloc() : super(GameListInitialState()) {
    on<FetchGamesEvent>((event, emit) async {
      emit(GameListLoadingState());
      try {
        final List<Game> games = await fetchGameList();
        emit(GameListLoadedState(games: games));
      } catch (e) {
        emit(GameListErrorState(error: e.toString()));
      }
    });
  }
}
