import 'package:equatable/equatable.dart';
import 'package:zau_layer_first/core/clean_code/result.dart';
import 'package:zau_layer_first/modules/domain/entities/home_entity.dart';

abstract class HomeState extends Equatable {
  final int time;
  HomeState() : time = DateTime.now().millisecondsSinceEpoch;

  @override
  List<Object?> get props => [time];
}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeNoInternetState extends HomeState {}

class HomeLoadedState extends HomeState {
  final NumberTestEntity? numberTests;
  HomeLoadedState({this.numberTests}) : super();

  @override
  List<Object?> get props => super.props..add(numberTests);
}

class HomeErrorState extends HomeState {
  final Result result;

  HomeErrorState({required this.result}) : super();

  @override
  List<Object?> get props => super.props..add(result);
}
