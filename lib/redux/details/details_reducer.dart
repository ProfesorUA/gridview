import 'package:gridview_transition/redux/base/base_actions.dart';
import 'package:gridview_transition/redux/details/details_actions.dart';
import 'package:gridview_transition/redux/details/details_state.dart';
import 'package:redux/redux.dart';

Reducer<DetailsState> detailsReducer = combineReducers<DetailsState>([
  TypedReducer<DetailsState, SaveData>(_saveData),
  TypedReducer<DetailsState, ShowError>(_showError),
  TypedReducer<DetailsState, CloseScreen>(_closeScreen),
  TypedReducer<DetailsState, ResetState>(_resetState),
]);

DetailsState _saveData(DetailsState state, SaveData action) {
  return state.copyWith(isLoading: true, error: null, shouldCloseScreen: false);
}

DetailsState _showError(DetailsState state, ShowError action) {
  return state.copyWith(
      isLoading: false, error: action.error, shouldCloseScreen: false);
}

DetailsState _closeScreen(DetailsState state, CloseScreen action) {
  return state.copyWith(isLoading: false, error: null, shouldCloseScreen: true);
}

DetailsState _resetState(DetailsState state, ResetState action) {
  return DetailsState.initial();
}
