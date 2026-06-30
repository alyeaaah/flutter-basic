import 'package:equatable/equatable.dart';
import 'package:zau_layer_first/core/clean_code/result.dart';

abstract class ProfileState extends Equatable {
  final int time;
  ProfileState() : time = DateTime.now().millisecondsSinceEpoch;

  @override
  List<Object?> get props => [time];
}

class ProfileInitialState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileNoInternetState extends ProfileState {}

class ProfileLoadedState extends ProfileState {
  final String? username;
  ProfileLoadedState({this.username}) : super();

  @override
  List<Object?> get props => super.props..add(username);
}

class ProfileErrorState extends ProfileState {
  final Result result;

  ProfileErrorState({required this.result}) : super();

  @override
  List<Object?> get props => super.props..add(result);
}
