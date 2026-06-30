import 'package:equatable/equatable.dart';
import 'package:zau_layer_first/core/clean_code/result.dart';

abstract class SummaryOrderState extends Equatable {
  final int time;
  SummaryOrderState() : time = DateTime.now().millisecondsSinceEpoch;

  @override
  List<Object?> get props => [time];
}

class SummaryOrderInitialState extends SummaryOrderState {}

class SummaryOrderLoadingState extends SummaryOrderState {}

class SummaryOrderNoInternetState extends SummaryOrderState {}

class SummaryOrderLoadedState extends SummaryOrderState {}

class SummaryOrderErrorState extends SummaryOrderState {
  final Result result;

  SummaryOrderErrorState({required this.result}) : super();

  @override
  List<Object?> get props => super.props..add(result);
}
