import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship_project/blocs/bottom_nav_bloc.dart';
import 'package:internship_project/screens/browse_screen.dart';
import 'package:internship_project/screens/music_screen.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavBloc(),
      child: BlocBuilder<BottomNavBloc, BottomNavState>(
        builder: (context, state) {
          final List<Widget> navScreen = [
            BrowseScreen(),
            MusicScreen(),
          ];

          final currIndex = (state is TabChangedState) ? state.tabIndex : 0;

          return Scaffold(
            body: navScreen[currIndex],
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: currIndex,
              onTap: (index) {
                context
                    .read<BottomNavBloc>()
                    .add(ChangeTabEvent(tabIndex: index));
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.games),
                  label: 'Browse Games',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.music_note),
                  label: 'Music',
                ),
              ],
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
              selectedItemColor: Colors.blue[400],
            ),
          );
        },
      ),
    );
  }
}
