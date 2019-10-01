import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gridview_transition/common/connectivity/connectivity.dart';
import 'package:gridview_transition/data/constants/app_routes.dart';
import 'package:gridview_transition/redux/base/app_state.dart';
import 'package:gridview_transition/redux/main/main_actions.dart';
import 'package:gridview_transition/ui/details/details_page.dart';
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

  _onDispose(Store<AppState> store) {}

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
          print(vm.shouldShowNoInternet);
          print(vm.isLoading);
          if (vm.isLoading) {
            return Container(
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              ),
            );
          } else if (vm.shouldShowNoInternet) {
            return Container(
              color: Colors.white,
              child: Center(
                child: Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("No internet connection"),
                      FlatButton(
                        child: Text("Retry"),
                        onPressed: () {
                          vm.loadData();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return GridView.builder(
                itemCount: vm.elements.length,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return AspectRatio(
                    aspectRatio: 1,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(AppRoutes.details,
                            arguments: DetailsPageArguments(
                                imageTag: 'detailsImage$index',
                                snapshot: vm.elements[index]));
                      },
                      child: Container(
                        margin: EdgeInsets.all(5),
                        child: ClipRRect(
                          clipBehavior: Clip.hardEdge,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
//                          borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  flex: 7,
                                  child: Hero(
                                    tag: 'detailsImage$index',
                                    child: Image.network(
                                      vm.elements[index].data['image_url'],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Center(
                                    child: Text(
                                      vm.elements[index].data['name'],
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Center(
                                    child: Text(
                                      "Rating: " +
                                          vm.elements[index].data['rating']
                                              .toString(),
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                });
          }
        },
      ),
    );
  }
}
