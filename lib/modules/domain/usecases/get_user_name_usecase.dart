import 'package:zau_layer_first/core/clean_code/result.dart';
import 'package:zau_layer_first/core/clean_code/usecase.dart';
import 'package:zau_layer_first/core/client_request.dart';
import 'package:zau_layer_first/modules/data/repositories/user_repository_impl.dart';
import 'package:zau_layer_first/modules/domain/entities/user_entity.dart';
import 'package:zau_layer_first/modules/domain/repositories/user_repository.dart';

class GetUserByUsernameUseCase extends UseCase<UserEntity, Params> {
  UserRepository? repository;
  GetUserByUsernameUseCase({this.repository});

  @override
  Future<Result<UserEntity>> call(Params params) async {
    if (repository == null) {
      if (!await hasInternetConnection) {
        return Result.noInternet();
      }
    }

    repository ??= UserRepositoryImpl(ClientRequest().dio);
    return repository!.getUserByUsername(params);
  }
}
