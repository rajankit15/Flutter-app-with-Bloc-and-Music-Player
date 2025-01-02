//game list
abstract class GameListEvent {}

class FetchGamesEvent extends GameListEvent {}

//game details
abstract class FetchGameDetailsEvent {}

class GameDetailsEvent extends FetchGameDetailsEvent {
  final String gameId;
  GameDetailsEvent({required this.gameId});
}
