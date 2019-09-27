import 'package:gridview_transition/redux/base/app_state.dart';
import 'package:gridview_transition/redux/main/main%20reducer.dart';

AppState appReducer(AppState state, action) {
  return AppState(mainState: mainReducer(state.mainState, action));
}