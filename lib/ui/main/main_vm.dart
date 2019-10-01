import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:gridview_transition/redux/base/app_state.dart';
import 'package:gridview_transition/redux/base/base_actions.dart';
import 'package:gridview_transition/redux/main/main_actions.dart';
import 'package:redux/redux.dart';

class MainViewModel extends Equatable {
  final bool isLoading;
  final bool isDefault;
  final Object error;
  final List<DocumentSnapshot> elements;
  final bool shouldShowNoInternet;
  final Function loadData;
  final Function resetState;

  MainViewModel({
    this.isLoading,
    this.isDefault,
    this.error,
    this.elements,
    this.shouldShowNoInternet,
    this.loadData,
    this.resetState,
  }) : super([isLoading, isDefault, error, elements, shouldShowNoInternet]);

  static MainViewModel fromStore(Store<AppState> store) {
    return MainViewModel(
      isDefault: store.state.mainState.isDefault(),
      isLoading: store.state.mainState.isLoading,
      error: store.state.mainState.error,
      elements: store.state.mainState.elements,
      shouldShowNoInternet: store.state.mainState.shouldShowNoInternet,
      loadData: () => store.dispatch(LoadData()),
      resetState: () => store.dispatch(ResetState()),
    );
  }
}
