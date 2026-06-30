import 'package:zau_layer_first/core/clean_code/result.dart';
import 'package:zau_layer_first/core/clean_code/usecase.dart';

import 'package:zau_layer_first/modules/domain/usecases/get_user_name_usecase.dart';
import 'package:zau_layer_first/modules/feature/account/profile/profile_state.dart';
import 'package:zau_layer_first/shared/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProfileBloc extends Cubit<ProfileState> {
  static const tag = "ProfileBloc";
  final GetUserByUsernameUseCase getUserByUsernameUseCase;
  ProfileBloc({required this.getUserByUsernameUseCase})
    : super(ProfileInitialState());
  String username = "";

  void validateView() {
    final box = Hive.box(Constants.authStorageKey);
    username = box.get('username', defaultValue: "") ?? "";
    emit(ProfileLoadedState());
  }

  Future<void> list(String username, String password) async {
    emit(ProfileLoadingState());
    final result = await getUserByUsernameUseCase.call(
      Params(data: {"username": username, "password": password}),
    );
    if (result.status is Success) {
      emit(ProfileLoadedState(username: username));
    } else {
      emit(ProfileErrorState(result: result));
      emit(ProfileLoadedState(username: null));
    }
  }
}
