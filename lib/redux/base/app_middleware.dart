import 'package:gridview_transition/redux/base/app_state.dart';
import 'package:gridview_transition/redux/details/details_middleware.dart';
import 'package:gridview_transition/redux/main/main_middleware.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> appMiddleware() {
  final appMiddleware = <Middleware<AppState>>[];
  appMiddleware.addAll(MainMiddleware().getMiddleware());
  appMiddleware.addAll(DetailsMiddleware().getMiddleware());
  return appMiddleware;
}