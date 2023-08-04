import 'package:eitherx/eitherx.dart';
import 'package:example/settings/models/settings_model.dart';
import 'package:example/core/failure.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base_use_case.dart';
import 'package:example/core/state_renderer.dart';

abstract class FlowState extends Equatable {
  StateRendererType getStateRendererType();

  String getMessage();
}


class InitialState extends FlowState {
  @override
  String getMessage() {
    return '';
  }

  @override
  StateRendererType getStateRendererType() => StateRendererType.contentState;

  List<Object?> get props => [];
}


class LoadingState extends FlowState {
  final StateRendererType type;
  final String? message;

  LoadingState({
    required this.type,
    this.message,
  });

  @override
  String getMessage() => message ?? '';

  @override
  StateRendererType getStateRendererType() => type;

  List<Object?> get props => [type, message];
}


class ErrorState extends FlowState {
  final StateRendererType type;
  final String? message;

  ErrorState({
    required this.type,
    this.message,
  });

  @override
  String getMessage() => message ?? '';

  @override
  StateRendererType getStateRendererType() => type;

  List<Object?> get props => [type, message];
}


class EmptyState extends FlowState {
  final StateRendererType type;
  final String? message;

  EmptyState({
    required this.type,
    this.message,
  });

  @override
  String getMessage() => message ?? '';

  @override
  StateRendererType getStateRendererType() => type;

  List<Object?> get props => [type, message];
}


class SuccessState<T> extends FlowState {
  final StateRendererType type;
  final String message;
  final T? data;

  SuccessState({
    required this.type,
    required this.message,
    this.data,
  });

  @override
  String getMessage() => message ?? '';

  @override
  StateRendererType getStateRendererType() => type;

  List<Object?> get props => [type, message];
}


class ContentState<T> extends FlowState {
  final StateRendererType? type;
  final String? message;
  final T? data;

  ContentState({
    this.type,
    this.message,
    this.data,
  });

  @override
  String getMessage() => message ?? '';

  @override
  StateRendererType getStateRendererType() => StateRendererType.contentState

  List<Object?> get props => [data];
}


