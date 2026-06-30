import 'package:zau_layer_first/core/clean_code/result.dart';
import 'package:zau_layer_first/core/clean_code/usecase.dart';
import 'package:zau_layer_first/modules/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<Result<String>> getUserLogin(Params params);

  Future<Result<UserEntity>> getUserByUsername(Params params);

  Future<Result<UserEntity>> createUser(Params params);
}
