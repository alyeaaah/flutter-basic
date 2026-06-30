import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

import 'result.dart';


abstract class UseCase<T, P> {
  Future<bool> get hasInternetConnection async {
    final results = await Connectivity().checkConnectivity();
    return !results.contains(ConnectivityResult.none);
  }
  Future<Result<T>> call(P params);
}


/// Default no params if the use case class does not need any param
class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}

class PaginationQueryParams extends Equatable {
  final int page;
  final int limit;
  final String? period;
  final String? startDate;
  final String? endDate;
  final String? city;
  final String? search;
  final String? type;

  const PaginationQueryParams({
    required this.page,
    required this.limit,
    this.period,
    this.startDate,
    this.endDate,
    this.city,
    this.search,
    this.type,
  });
  Map<String, dynamic> toMap() {
    return Map.fromEntries([
      MapEntry('page', page),
      MapEntry('limit', limit),
      if (period != null) MapEntry('period', period),
      if (startDate != null) MapEntry('start_date', startDate),
      if (endDate != null) MapEntry('end_date', endDate),
      if (city != null) MapEntry('city', city),
      if (search != null) MapEntry('search', search),
      if (type != null) MapEntry('type', type),
    ]);
  }

  @override
  List<Object?> get props => [
        page,
        limit,
        period,
        startDate,
        endDate,
        type,
      ];

  PaginationQueryParams copyWith({
    int? page,
    int? limit,
    String? period,
    String? startDate,
    String? endDate,
    String? city,
    String? search,
    String? type,
  }) {
    return PaginationQueryParams(
      page: page ?? this.page,
      limit: limit ?? this.limit,
      period: period ?? this.period,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      city: city ?? this.city,
      search: search ?? this.search,
      type: type ?? this.type,
    );
  }
}

class Params extends Equatable {
  final String? endPoint;
  final Map<String, dynamic>? queryParams;
  final Map<String, dynamic>? data;

  const Params({
    this.endPoint,
    this.queryParams,
    this.data,
  });

  @override
  List<Object?> get props => [
        endPoint,
        queryParams,
        data,
      ];
}
