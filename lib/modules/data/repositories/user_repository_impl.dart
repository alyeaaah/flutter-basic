import 'package:zau_layer_first/core/clean_code/result.dart';
import 'package:zau_layer_first/core/clean_code/usecase.dart';
import 'package:zau_layer_first/core/request_exception.dart';
import 'package:zau_layer_first/modules/data/model/user_model.dart';
import 'package:zau_layer_first/modules/domain/entities/user_entity.dart';
import 'package:zau_layer_first/modules/domain/repositories/user_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class UserRepositoryImpl extends UserRepository {
  final Dio dio;
  UserRepositoryImpl(this.dio);

  @override
  Future<Result<String>> getUserLogin(Params params) async {
    const endPoint = "/user/login";
    try {
      final response = await dio.get(
        endPoint,
        queryParameters: params.data,
        options: Options(responseType: ResponseType.plain),
      );

      return Result.success(response.data);
    } on DioException catch (e) {
      final message =
          e.response?.data.toString() ??
          RequestException.fromDioError(e).toString();
      return Result.error(message: message, code: e.response?.statusCode ?? -1);
    } catch (e) {
      return Result.error(message: 'Unable to get user login');
    }
  }

  @override
  Future<Result<UserEntity>> getUserByUsername(Params params) async {
    const endPoint = "/user/";
    try {
      final response = await dio.get(endPoint + params.data.toString());
      return Result.success(
        UserModel.fromJson(response.data),
        message: response.data.toString(),
      );
    } on DioException catch (e) {
      final message =
          e.response?.data.toString() ??
          RequestException.fromDioError(e).toString();
      return Result.error(message: message, code: e.response?.statusCode ?? -1);
    } catch (e) {
      debugPrint("getUserByUsername error: ${e.toString()}");
      return Result.error(message: 'Unable to get user by username');
    }
  }

  @override
  Future<Result<UserEntity>> createUser(Params params) async {
    const endPoint = "/user/";
    try {
      final response = await dio.post(endPoint, data: params.data);
      return Result.success(
        UserModel.fromJson(response.data),
        message: response.data.toString(),
      );
    } on DioException catch (e) {
      final message =
          e.response?.data.toString() ??
          RequestException.fromDioError(e).toString();
      return Result.error(message: message, code: e.response?.statusCode ?? -1);
    } catch (e) {
      debugPrint("createUser error: ${e.toString()}");
      return Result.error(message: 'Unable to create user');
    }
  }
}
