import 'package:harmony/base_project/api/exception.dart';
import 'package:harmony/base_project/package_widget.dart';

class Service {
  late Dio _dio;
  final String _baseUrl = 'http://192.168.1.152:3000/';

  Service() {
    _dio = Dio();
    _dio.interceptors.add(PrettyDioLogger());
  }

  Future<Result<T, Exception>> postData<T>({
    required String endpoint,
    Map<String, dynamic>? body,
  }) async {
    try {
      final response = await _dio.post("$_baseUrl$endpoint", data: body);
      if(response.statusCode == 200) {
        return Success<T, Exception>(response.data);
      } else {
        return Failure(Exception('Send Failed: ${response.statusCode}'));
      }
    } catch (e) {
      return Failure<T, Exception>(e as Exception);
    }
  }
}