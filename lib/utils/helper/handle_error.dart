import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture/utils/utils.dart' show Message;
mixin HandleError {
  String handleDioError(DioError error) {
      switch (error.type) {
        case DioErrorType.connectTimeout:
          return Message.errorConnectTimeout;
        case DioErrorType.cancel:
          return Message.errorCancel;
        case DioErrorType.response:
          return Message.errorStatusCode;
        case DioErrorType.sendTimeout:
          return Message.errorConnectTimeout;
        case DioErrorType.receiveTimeout:
          return Message.errorConnectTimeout;
        case DioErrorType.other:
          return Message.errorNotConnect;
        default:
          return '';
      }
  }
  String handleErrorApi(int type){
    switch(type){
      case 0:
        return '';
      default:
        return '';
    }
  }
}
