import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final Box _userBox = Hive.box('userBox');

  void login(String email, String password) {
    if (email.isEmpty || password.isEmpty) {
      emit(LoginError("Email and password cannot be empty"));
      return;
    }

    // Validate email and password logic (mock validation for now)
    if (email == "mostafa" && password == "123456") {
      _userBox.put('email', email);
      _userBox.put('isLoggedIn', true);
      emit(LoginSuccess());
    } else {
      emit(LoginError("Invalid email or password"));
    }
  }

  void togglePasswordVisibility(bool isObscure) {
    emit(LoginPasswordVisibilityChanged(!isObscure));
  }
}
