import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship_project/blocs/game_details_state.dart';
import 'package:internship_project/blocs/game_events.dart';
import 'package:internship_project/screens/enquiry_page.dart';
import 'package:internship_project/widgets/custom_button.dart';

class GameDetailsScreen extends StatelessWidget {
  final String id;
  const GameDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    context.read<GameDetailsBloc>().add(GameDetailsEvent(gameId: id));
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<GameDetailsBloc, GameDetailsState>(
        builder: (context, state) {
          if (state is GameDetailsLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is GameDetailsLoadedState) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  CachedNetworkImage(
                    imageUrl: state.game.backgroundImage,
                    fit: BoxFit.cover,
                    height: 300,
                    width: double.infinity,
                    alignment: Alignment.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            state.game.name,
                            style: TextStyle(
                              fontFamily: 'times new roman',
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(
                              Icons.star_border_outlined,
                              color: Colors.amber,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              '${state.game.rating} (${state.game.ratingCount}) rating',
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text('Publisher : ${state.game.publisher}'),
                        const SizedBox(height: 4),
                        Text('Released : ${state.game.released}'),
                        const SizedBox(height: 6),
                        Text(
                          'About',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                        Text(
                          state.game.description,
                          style: TextStyle(fontSize: 15, height: 1.4),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (state is GameDetailsErrorState) {
            return Center(child: Text(state.error));
          } else {
            return Center(child: Text('No games found'));
          }
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: customButton(
          () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return EnquiryPage();
              }),
            );
          },
          'Enquire Now',
        ),
      ),
    );
  }
}
