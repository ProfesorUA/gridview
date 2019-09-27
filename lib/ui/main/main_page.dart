import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gridview_transition/redux/base/app_state.dart';
import 'package:gridview_transition/redux/main/main_actions.dart';
import 'package:gridview_transition/ui/main/main_vm.dart';
import 'package:redux/redux.dart';

class MainPage extends StatefulWidget {
  MainPage();

  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  @override
  void dispose() {
    super.dispose();
  }

  _onInit(Store<AppState> store) {
    store.dispatch(LoadData());
  }

  _onDispose(Store<AppState> store) {
  }

  _onWillChange(MainViewModel vm) {
  }

  _onDidChange(MainViewModel vm) {
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoreConnector(
        distinct: true,
        onInit: _onInit,
        onDispose: _onDispose,
        onWillChange: _onWillChange,
        onDidChange: _onDidChange,
        converter: MainViewModel.fromStore,
        builder: (BuildContext context, MainViewModel vm) {
          if (vm.isLoading) {
            return Container(
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}