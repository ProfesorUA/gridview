import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:gridview_transition/redux/base/app_state.dart';
import 'package:gridview_transition/redux/base/base_actions.dart';
import 'package:gridview_transition/redux/details/details_actions.dart';
import 'package:redux/redux.dart';

class DetailsPageViewModel extends Equatable {
  final bool isLoading;
  final bool isDefault;
  final bool shouldCloseScreen;
  final Object error;
  final Function(String id, double rating, String description) saveData;
  final Function resetState;

  DetailsPageViewModel({
    this.isLoading,
    this.isDefault,
    this.shouldCloseScreen,
    this.error,
    this.saveData,
    this.resetState,
  }) : super([isLoading, isDefault, shouldCloseScreen, error]);

  static DetailsPageViewModel fromStore(Store<AppState> store) {
    return DetailsPageViewModel(
      isDefault: store.state.detailsState.isDefault(),
      isLoading: store.state.detailsState.isLoading,
      shouldCloseScreen: store.state.detailsState.shouldCloseScreen,
      error: store.state.detailsState.error,
      saveData: (id, rating, description) => store.dispatch(
        SaveData(elementID: id, description: description, rating: rating),
      ),
      resetState: () => store.dispatch(ResetState()),
    );
  }
}
