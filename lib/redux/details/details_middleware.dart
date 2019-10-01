import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gridview_transition/common/connectivity/connectivity.dart';
import 'package:gridview_transition/redux/base/app_state.dart';
import 'package:gridview_transition/redux/base/base_actions.dart';
import 'package:gridview_transition/redux/details/details_actions.dart';
import 'package:redux/redux.dart';

class DetailsMiddleware {

  List<Middleware<AppState>> getMiddleware() {
    return <Middleware<AppState>>[
      TypedMiddleware<AppState, SaveData>(_saveData),
    ];
  }

  Future _saveData(
      Store<AppState> store,
      SaveData action,
      NextDispatcher next,
      ) async {
    next(action);


    NetworkCheck().checkInternet((isInternetAvailable) async {
      if (isInternetAvailable) {
        Map<String, dynamic> data = new Map<String, dynamic>();
        data["rating"] = action.rating.toInt();
        data["description"] = action.description;
        await Firestore.instance.collection('elements').document(action.elementID).updateData(data).then((result) {
          store.state.mainState.elements.firstWhere((element) { return element.documentID == action.elementID; }).data["rating"] = action.rating.toInt();
          store.state.mainState.elements.firstWhere((element) { return element.documentID == action.elementID; }).data["description"] = action.description;
          store.dispatch(CloseScreen());
        }).catchError((error) {
          store.dispatch(ShowError(error: error));
        });
      } else {
        store.dispatch(ShowError(error: "No internet connection"));
      }
    });

  }
}
