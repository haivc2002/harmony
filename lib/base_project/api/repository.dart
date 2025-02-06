import 'package:harmony/base_project/api/service.dart';
import 'package:harmony/base_project/package_widget.dart';
import 'package:harmony/model/response/model_info_user.dart';


mixin Repository {
  final Service _service = Service("http://192.168.1.26:3000/");

  // Future<Result<ModelInfoUser, Exception>> postLoginWithGoogle(String? email) async {
  //   return await _service.post<ModelInfoUser>(
  //     endpoint: "api/login/google",
  //     data: {"email": email},
  //   );
  // }

  Future<Result<ModelInfoUser>> postLogin(String email, String password) async {
    return await _service.post<ModelInfoUser>(
      endpoint: "auth/login",
      data: {"email": email, "password": password, "language": Global.getString(Constant.languageStore)},
      fromJson: (json) => ModelInfoUser.fromJson(json),
    );
  }
}