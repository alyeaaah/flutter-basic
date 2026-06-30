import 'package:zau_layer_first/modules/feature/order/summary_order_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SummaryOrderBloc extends Cubit<SummaryOrderState> {
  static const tag = "SummaryOrderBloc";
  SummaryOrderBloc() : super(SummaryOrderInitialState());

  void validateView() {
    emit(SummaryOrderLoadedState());
  }

  Future<void> fetchOrder() async {
    emit(SummaryOrderLoadingState());
    emit(SummaryOrderLoadedState());
  }
}
