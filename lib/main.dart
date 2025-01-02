import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship_project/blocs/game_details_state.dart';
import 'package:internship_project/blocs/game_events.dart';
import 'package:internship_project/blocs/game_list_states.dart';
import 'package:internship_project/blocs/music_player_bloc.dart';
import 'package:internship_project/landing_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => GameListBloc()..add(FetchGamesEvent()),
          ),
          BlocProvider(
            create: (context) => GameDetailsBloc(),
          ),
          BlocProvider(
            create: (context) => MusicPlayerBloc(),
          ),
        ],
        child: LandingPage(),
      ),
    );
  }
}
