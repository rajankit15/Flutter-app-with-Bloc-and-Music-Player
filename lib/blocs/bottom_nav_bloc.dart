import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BottomNavEvent {}

class ChangeTabEvent extends BottomNavEvent {
  final int tabIndex;
  ChangeTabEvent({required this.tabIndex});
}

abstract class BottomNavState {}

class TabChangedState extends BottomNavState {
  final int tabIndex;
  TabChangedState({required this.tabIndex});
}

class BottomNavBloc extends Bloc<BottomNavEvent, BottomNavState> {
  BottomNavBloc() : super(TabChangedState(tabIndex: 0)) {
    on<ChangeTabEvent>(
      (event, emit) {
        emit(TabChangedState(tabIndex: event.tabIndex));
      },
    );
  }
}
