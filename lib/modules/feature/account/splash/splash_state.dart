import 'package:zau_layer_first/core/clean_code/result.dart';
import 'package:equatable/equatable.dart';

abstract class SplashState extends Equatable {
  final num time;
  SplashState() : time = DateTime.now().millisecondsSinceEpoch;

  @override
  List<Object?> get props => [time];
}

class SplashInitialState extends SplashState {}

class SplashLoadingState extends SplashState {}

class SplashNoInternetState extends SplashState {}

class SplashLoadedState extends SplashState {
  final String? authKey;

  SplashLoadedState({this.authKey}) : super();

  @override
  List<Object?> get props => super.props..add(authKey);
}

class SplashErrorState extends SplashState {
  final Result result;

  SplashErrorState({required this.result}) : super();

  @override
  List<Object?> get props => super.props..add(result);
}

class SplashSaveDeviceState extends SplashState {}
