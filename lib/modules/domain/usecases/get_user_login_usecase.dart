import 'package:zau_layer_first/core/clean_code/result.dart';
import 'package:zau_layer_first/core/clean_code/usecase.dart';
import 'package:zau_layer_first/core/client_request.dart';
import 'package:zau_layer_first/modules/data/repositories/user_repository_impl.dart';
import 'package:zau_layer_first/modules/domain/repositories/user_repository.dart';

class GetUserLoginUseCase extends UseCase<String, Params> {
  UserRepository? repository;
  GetUserLoginUseCase({this.repository});

  @override
  Future<Result<String>> call(Params params) async {
    if (repository == null) {
      if (!await hasInternetConnection) {
        return Result.noInternet();
      }
    }

    repository ??= UserRepositoryImpl(ClientRequest().dio);
    return repository!.getUserLogin(params);
  }
}
