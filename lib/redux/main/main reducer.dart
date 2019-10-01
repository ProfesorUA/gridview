import 'package:gridview_transition/redux/base/base_actions.dart';
import 'package:gridview_transition/redux/main/main_actions.dart';
import 'package:gridview_transition/redux/main/main_state.dart';
import 'package:redux/redux.dart';

Reducer<MainState> mainReducer = combineReducers<MainState>([
  TypedReducer<MainState, ShowError>(_showError),
  TypedReducer<MainState, ResetState>(_resetState),
  TypedReducer<MainState, LoadData>(_loadData),
  TypedReducer<MainState, ShowResults>(_showResults),
  TypedReducer<MainState, ShowNoInternetConnection>(_showNoInternetConnection),
]);

MainState _showError(MainState state, ShowError action) {
  return state.copyWith(isLoading: false, error: action.error);
}

MainState _resetState(MainState state, ResetState action) {
  return MainState.initial();
}

MainState _loadData(MainState state, LoadData action) {
  return state.copyWith(
      isLoading: true, error: null, shouldShowNoInternet: false);
}

MainState _showResults(MainState state, ShowResults action) {
  return state.copyWith(
      isLoading: false, elements: action.elements, shouldShowNoInternet: false);
}

MainState _showNoInternetConnection(
    MainState state, ShowNoInternetConnection action) {
  return state.copyWith(
      isLoading: false, error: null, shouldShowNoInternet: true);
}
