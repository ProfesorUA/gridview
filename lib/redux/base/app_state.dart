import 'package:equatable/equatable.dart';
import 'package:gridview_transition/redux/main/main_state.dart';

class AppState extends Equatable {
  MainState mainState;

  AppState({this.mainState});

  factory AppState.initial() {
    return AppState(mainState: MainState.initial());
  }

  AppState copyWith(MainState mainState) {
    return AppState(mainState: mainState ?? this.mainState);
  }
}
