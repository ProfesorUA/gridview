import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gridview_transition/redux/base/app_state.dart';
import 'package:gridview_transition/redux/base/app_store.dart';
import 'package:gridview_transition/ui/main/main_page.dart';
import 'package:redux/redux.dart';

void main() {
  final store = appStore();
  runApp(GridViewApp(store));
}

class GridViewApp extends StatefulWidget {
  final Store<AppState> store;

  GridViewApp(this.store);

  @override
  State<StatefulWidget> createState() => GridViewAppState();
}

class GridViewAppState extends State<GridViewApp> {
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: widget.store,
      child: MaterialApp(
        home: MainPage(),
        onGenerateRoute: (RouteSettings settings) {
          final routes = <String, WidgetBuilder>{};

          final builder = routes[settings.name];
          return MaterialPageRoute(
            builder: (context) => builder(context),
          );
        },
      ),
    );
  }
}
