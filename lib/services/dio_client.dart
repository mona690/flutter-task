import 'package:dio/dio.dart';

class DioClient {
 static var client = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 20)
    )
  );
}
