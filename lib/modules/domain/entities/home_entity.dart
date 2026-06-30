import 'package:equatable/equatable.dart';

class NumberTestEntity extends Equatable {
  final int reverse;
  final int difference;

  const NumberTestEntity({required this.reverse, required this.difference});

  @override
  List<Object?> get props => [reverse, difference];
}
