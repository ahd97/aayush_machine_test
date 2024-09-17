import 'package:aayush_machine_test/core/di/api/api_end_points.dart';
import 'package:aayush_machine_test/core/di/api/http_client.dart';
import 'package:aayush_machine_test/model/login_response.dart';

import '../../../locator.dart';

abstract class IUserAuthRepository {
  Future<LoginResponse> login(Map<String, dynamic> data);
}

class UserAuthRepository extends IUserAuthRepository {
  @override
  Future<LoginResponse> login(Map<String, dynamic> data) async {
    final client = locator<HttpClient>();
    final response = await client.post(APIEndPoints.login, body: data);
    final finalData = LoginResponse.fromJson(response);
    return finalData;
  }
}

final authRepo = locator<UserAuthRepository>();
