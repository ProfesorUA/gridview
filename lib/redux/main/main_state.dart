import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class MainState extends Equatable {
  final bool isLoading;
  final Object error;

  MainState({
    this.isLoading,
    this.error,
  }) : super([
    isLoading,
    error,
  ]);

  factory MainState.initial() {
    return MainState(
      isLoading: false,
      error: null,
    );
  }

  MainState copyWith({
    bool isLoading,
    Object error,
  }) {
    return MainState(
      isLoading: isLoading,
      error: error,
    );
  }

  bool isDefault() {
    return isLoading == false && error == null;
  }
}
