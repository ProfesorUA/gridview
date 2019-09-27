import 'package:gridview_transition/redux/base/app_middleware.dart';
import 'package:gridview_transition/redux/base/app_reducer.dart';
import 'package:gridview_transition/redux/base/app_state.dart';
import 'package:redux/redux.dart';

Store<AppState> appStore() {
  return Store(
    appReducer,
    initialState: AppState.initial(),
    middleware: appMiddleware(),
  );
}
