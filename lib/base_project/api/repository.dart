import 'package:harmony/base_project/api/exception.dart';
import 'package:harmony/base_project/api/service.dart';
import 'package:harmony/model/response/model_info_user.dart';


mixin Repository {
  final Service _service = Service();

  Future<Result<ModelInfoUser, Exception>> postLoginWithGoogle(String? email) async {
    return await _service.postData<ModelInfoUser>(
      endpoint: "api/login/google",
      body: {"email": email},
    );
  }

  Future<Result<ModelInfoUser, Exception>> postLogin(String email, String password) async {
    return await _service.postData<ModelInfoUser>(
      endpoint: "api/login/google",
      body: {"email": email, "password": password},
    );
  }
}