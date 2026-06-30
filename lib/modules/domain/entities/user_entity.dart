import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int id;
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String phone;
  final int userStatus;

  const UserEntity({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.phone,
    required this.userStatus,
  });

  @override
  List<Object?> get props => [
    id,
    username,
    firstName,
    lastName,
    email,
    password,
    phone,
    userStatus,
  ];
}
