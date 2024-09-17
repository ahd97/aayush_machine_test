import 'package:aayush_machine_test/core/db/app_db.dart';
import 'package:aayush_machine_test/core/di/api/repo/user_authentication_repository.dart';
import 'package:aayush_machine_test/core/di/api/req_params.dart' as Req;
import 'package:aayush_machine_test/model/login_response.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login(String username, String password) async {
    emit(LoginLoading());

    try {
      var req = Map.of({
        Req.email: username,
        Req.password: password
      });
      var response = await authRepo.login(req);
      if (response != null || (response.token??"").isNotEmpty) {
        appDB.token = response.token??"";
        emit(LoginSuccess(loginResponse: response));
      } else {
        emit(LoginFailure('Invalid credentials'));
      }
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}
