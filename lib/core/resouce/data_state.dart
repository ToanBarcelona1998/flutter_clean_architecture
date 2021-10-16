import 'package:dio/dio.dart';
abstract class DataState<T>{
  final T ?data;
  final DioError ?error;

  const DataState({this.data, this.error});
}

class DataSuccess<T> extends DataState<T>{
  const DataSuccess({T ?t}) : super(data: t);
}

class DataError<T> extends DataState<T>{
  const DataError({DioError ?dioError}) : super(error: dioError);
}