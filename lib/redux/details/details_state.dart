import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class DetailsState extends Equatable {
  final bool isLoading;
  final Object error;
  final bool shouldCloseScreen;

  DetailsState({
    this.isLoading,
    this.error,
    this.shouldCloseScreen,
  }) : super([isLoading, error, shouldCloseScreen]);

  factory DetailsState.initial() {
    return DetailsState(
      isLoading: false,
      error: null,
      shouldCloseScreen: false,
    );
  }

  DetailsState copyWith({
    bool isLoading,
    Object error,
    bool shouldCloseScreen,
  }) {
    return DetailsState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      shouldCloseScreen: shouldCloseScreen ?? this.shouldCloseScreen,
    );
  }

  bool isDefault() {
    return isLoading == false && error == null && shouldCloseScreen == false;
  }
}
