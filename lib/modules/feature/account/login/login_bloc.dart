import 'package:zau_layer_first/core/clean_code/result.dart';
import 'package:zau_layer_first/core/clean_code/usecase.dart';
import 'package:zau_layer_first/modules/domain/usecases/get_user_login_usecase.dart';
import 'package:zau_layer_first/modules/feature/account/login/login_state.dart';
import 'package:zau_layer_first/shared/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LoginBloc extends Cubit<LoginState> {
  static const tag = "LoginBloc";
  final GetUserLoginUseCase loginUseCase;
  LoginBloc({required this.loginUseCase}) : super(LoginInitialState());

  void validateView() {
    emit(LoginLoadedState());
  }

  Future<void> login(String username, String password) async {
    emit(LoginLoadingState());
    final result = await loginUseCase.call(
      Params(data: {"username": username, "password": password}),
    );
    if (result.status is Success) {
      final box = Hive.box(Constants.authStorageKey);
      box.put('username', username);
      emit(LoginLoadedState(username: username));
    } else {
      emit(LoginErrorState(result: result));
      emit(LoginLoadedState(username: null));
    }
  }
}
