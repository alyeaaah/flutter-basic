import 'package:equatable/equatable.dart';
import 'package:zau_layer_first/core/clean_code/result.dart';

abstract class LoginState extends Equatable {
  final int time;
  LoginState() : time = DateTime.now().millisecondsSinceEpoch;

  @override
  List<Object?> get props => [time];
}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginNoInternetState extends LoginState {}

class LoginLoadedState extends LoginState {
  final String? username;
  LoginLoadedState({this.username}) : super();

  @override
  List<Object?> get props => super.props..add(username);
}

class LoginErrorState extends LoginState {
  final Result result;

  LoginErrorState({required this.result}) : super();

  @override
  List<Object?> get props => super.props..add(result);
}
