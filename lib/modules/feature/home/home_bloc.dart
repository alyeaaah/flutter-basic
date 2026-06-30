import 'package:zau_layer_first/core/clean_code/result.dart';
import 'package:zau_layer_first/modules/domain/entities/home_entity.dart';
import 'package:zau_layer_first/modules/feature/home/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Cubit<HomeState> {
  static const tag = "HomeBloc";
  HomeBloc() : super(HomeInitialState());

  void validateView() {
    emit(HomeLoadedState());
  }

  Future<void> getData() async {
    emit(HomeLoadingState());

    emit(HomeLoadedState());
  }

  void validateNumber(String number) {
    if (number.isEmpty) {
      emit(HomeErrorState(result: Result.error(message: 'Number is empty')));
    } else if (!RegExp(r'[-0-9.,]').hasMatch(number)) {
      // allow float number and negative number
      emit(
        HomeErrorState(result: Result.error(message: 'Number is not valid')),
      );
    }
    int cleanedNumber =
        int.tryParse(number.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
    int reverse = int.parse(cleanedNumber.toString().split('').reversed.join());
    int difference = (cleanedNumber - reverse).abs();
    NumberTestEntity result = NumberTestEntity(
      reverse: reverse,
      difference: difference,
    );
    emit(HomeLoadedState(numberTests: result));
  }
}
