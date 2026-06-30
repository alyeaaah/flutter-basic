import 'package:zau_layer_first/shared/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'splash_state.dart';

class SplashBloc extends Cubit<SplashState> {
  static const tag = "SplashBloc";
  SplashBloc() : super(SplashInitialState());

  bool isLogin = false;
  void checkIfUserLoggedIn() async {
    emit(SplashLoadingState());
    var box = Hive.box(Constants.authStorageKey);
    final key = await box.get(Constants.authStorageKey);
    if (key != null) {
      emit(SplashLoadedState(authKey: key));
    } else {
      emit(SplashLoadedState(authKey: null));
    }
  }
}
