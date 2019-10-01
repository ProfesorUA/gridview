import 'package:equatable/equatable.dart';
import 'package:gridview_transition/redux/details/details_state.dart';
import 'package:gridview_transition/redux/main/main_state.dart';

class AppState extends Equatable {
  MainState mainState;
  DetailsState detailsState;

  AppState({this.mainState, this.detailsState});

  factory AppState.initial() {
    return AppState(
        mainState: MainState.initial(), detailsState: DetailsState.initial());
  }

  AppState copyWith(MainState mainState, DetailsState detailsState) {
    return AppState(
        mainState: mainState ?? this.mainState,
        detailsState: detailsState ?? this.detailsState);
  }
}
