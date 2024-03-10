import 'package:bloc/bloc.dart';
import 'package:compasia/utils/secure_storage.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> sendLogin(String username, String password) async {
    emit(LoginLoading());

    await Future.delayed(const Duration(seconds: 2));

    //mock login
    if (username == 'admin' || password == 'password') {
      //save user token random
      await SecureStorage().writeSecureData('token', '123456789');

      emit(LoginPass());
    } else {
      //
      emit(LoginFailed());
    }
  }
}
