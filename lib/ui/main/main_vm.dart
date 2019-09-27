import 'package:equatable/equatable.dart';
import 'package:gridview_transition/redux/base/app_state.dart';
import 'package:redux/redux.dart';

class MainViewModel extends Equatable {
  final bool isLoading;
  final bool isDefault;
  final Object error;

  MainViewModel({
    this.isLoading,
    this.isDefault,
    this.error,
  }) : super([isLoading, isDefault, error]);

  static MainViewModel fromStore(Store<AppState> store) {
    return MainViewModel(
      isDefault: store.state.mainState.isDefault(),
      isLoading: store.state.mainState.isLoading,
      error: store.state.mainState.error,
    );
  }
}
