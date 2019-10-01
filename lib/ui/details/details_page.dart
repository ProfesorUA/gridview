import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gridview_transition/redux/base/app_state.dart';
import 'package:gridview_transition/redux/main/main_actions.dart';
import 'package:gridview_transition/ui/details/details_vm.dart';
import 'package:gridview_transition/ui/main/main_vm.dart';
import 'package:redux/redux.dart';

class DetailsPageArguments {
  String imageTag;
  DocumentSnapshot snapshot;

  DetailsPageArguments({this.imageTag, this.snapshot});
}

class DetailsPage extends StatefulWidget {
  DetailsPageArguments arguments;

  DetailsPage({this.arguments});

  @override
  State<StatefulWidget> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  double _sliderValue = 0;
  TextEditingController _textFieldController;
  GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  void initState() {
    super.initState();

    _scaffoldKey = GlobalKey<ScaffoldState>();
    _sliderValue = (widget.arguments.snapshot.data['rating'] as int).toDouble();
    _textFieldController = TextEditingController();
    _textFieldController.text = widget.arguments.snapshot.data['description'];
  }

  @override
  void dispose() {
    super.dispose();
  }

  _onInit(Store<AppState> store) {
    store.dispatch(LoadData());
  }

  _onDispose(Store<AppState> store) {}

  _onWillChange(DetailsPageViewModel vm) {
  }

  _onDidChange(DetailsPageViewModel vm) {
    if (vm.shouldCloseScreen) {
      Navigator.of(context).pop();
    }
    if (vm.error != null) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(
            vm.error.toString(),
          ),
        ),
      );
    }
  }

  _saveDataIfNeeded(DetailsPageViewModel vm) {
    if (_sliderValue !=
            (widget.arguments.snapshot.data['rating'] as int).toDouble() ||
        _textFieldController.text !=
            widget.arguments.snapshot.data['description']) {
      vm.saveData(widget.arguments.snapshot.documentID, _sliderValue,
          _textFieldController.text);
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: StoreConnector(
        distinct: true,
        onInit: _onInit,
        onDispose: _onDispose,
        onWillChange: _onWillChange,
        onDidChange: _onDidChange,
        converter: DetailsPageViewModel.fromStore,
        builder: (BuildContext context, DetailsPageViewModel vm) {
          return SafeArea(
            child: vm.isLoading
                ? Container(
                    color: Colors.white,
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                      ),
                    ),
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        height: 44,
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                            ),
                            InkWell(
                              onTap: () {
                                _saveDataIfNeeded(vm);
                              },
                              child: Icon(
                                Icons.arrow_back,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Hero(
                            tag: widget.arguments.imageTag,
                            child: Image.network(
                              widget.arguments.snapshot.data['image_url'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                widget.arguments.snapshot.data['name'],
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text("Rating"),
                              Slider(
                                min: 0,
                                max: 5,
                                divisions: 5,
                                label: '$_sliderValue',
                                onChanged: (value) {
                                  setState(() {
                                    _sliderValue = value;
                                  });
                                },
                                value: _sliderValue,
                              ),
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(),
                                  expands: true,
                                  minLines: null,
                                  maxLines: null,
                                  controller: _textFieldController,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
