import 'package:zau_layer_first/modules/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel.fromJson(Map<String, dynamic> json)
    : super(
        id: json['id'] ?? 0,
        username: json['username'] ?? '',
        firstName: json['firstName'] ?? '',
        lastName: json['lastName'] ?? '',
        email: json['email'] ?? '',
        password: json['password'] ?? '',
        phone: json['phone'] ?? '',
        userStatus: json['userStatus'] ?? 0,
      );
}
