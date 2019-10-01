import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gridview_transition/common/connectivity/connectivity.dart';
import 'package:gridview_transition/redux/base/app_state.dart';
import 'package:gridview_transition/redux/base/base_actions.dart';
import 'package:gridview_transition/redux/main/main_actions.dart';
import 'package:redux/redux.dart';

class MainMiddleware {
//  final AuthRepo authRepo;
//
//  LoginMiddleware(this.authRepo);

  List<Middleware<AppState>> getMiddleware() {
    return <Middleware<AppState>>[
      TypedMiddleware<AppState, LoadData>(_loadData),
    ];
  }

  Future _loadData(
    Store<AppState> store,
    LoadData action,
    NextDispatcher next,
  ) async {
    next(action);
    NetworkCheck().checkInternet((isInternetAvailable) async {
      if (isInternetAvailable) {
        await Firestore.instance
            .collection('elements')
            .getDocuments().then((result) {
          store.dispatch(ShowResults(elements: result.documents));
        })
            .catchError((error) {
          store.dispatch(ShowError(error: error));
        });
      } else {
        store.dispatch(ShowNoInternetConnection());
      }
    });
  }
}
