import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class MainState extends Equatable {
  final bool isLoading;
  final Object error;
  final List<DocumentSnapshot> elements;
  final bool shouldShowNoInternet;

  MainState({
    this.isLoading,
    this.error,
    this.elements,
    this.shouldShowNoInternet
  }) : super([
    isLoading,
    error,
    elements,
    shouldShowNoInternet
  ]);

  factory MainState.initial() {
    return MainState(
      isLoading: false,
      error: null,
      elements: [],
      shouldShowNoInternet: false,
    );
  }

  MainState copyWith({
    bool isLoading,
    Object error,
    List<DocumentSnapshot> elements,
    bool shouldShowNoInternet
  }) {
    return MainState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      elements: elements ?? this.elements,
      shouldShowNoInternet: shouldShowNoInternet ?? this.shouldShowNoInternet,
    );
  }

  bool isDefault() {
    return isLoading == false && error == null && elements == [];
  }
}
