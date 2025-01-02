import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship_project/blocs/game_details_state.dart';
import 'package:internship_project/blocs/game_events.dart';
import 'package:internship_project/blocs/game_list_states.dart';
import 'package:internship_project/screens/game_details_screen.dart';
import 'package:internship_project/widgets/game_card.dart';

class BrowseScreen extends StatelessWidget {
  const BrowseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<GameListBloc>().add(FetchGamesEvent());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Browse Games',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        child: BlocBuilder<GameListBloc, GameListState>(
          builder: (context, state) {
            if (state is GameListLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is GameListLoadedState) {
              return GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 3,
                  crossAxisSpacing: 2.5,
                  childAspectRatio: 0.8,
                ),
                itemCount: state.games.length,
                itemBuilder: (context, index) {
                  // print(state.games[index].id);
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) => GameDetailsBloc(),
                            child: GameDetailsScreen(id: state.games[index].id),
                          ),
                        ),
                      );
                    },
                    child: gameCard(state.games[index]),
                  );
                },
              );
            } else if (state is GameListErrorState) {
              return Center(child: Text(state.error));
            } else {
              return Center(child: Text('No games found'));
            }
          },
        ),
      ),
    );
  }
}
