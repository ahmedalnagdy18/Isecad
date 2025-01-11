import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:iscad/all_curd.dart';
import 'package:iscad/core/common/buttons.dart';
import 'package:iscad/core/common/textfield.dart';
import 'package:iscad/login_cuibt/login_cubit.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: _LoginPageView(),
    );
  }
}

class _LoginPageView extends StatefulWidget {
  @override
  State<_LoginPageView> createState() => _LoginPageViewState();
}

class _LoginPageViewState extends State<_LoginPageView> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AllProductsPage(),
              ),
            );
          } else if (state is LoginError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<LoginCubit>();

          bool isObscure =
              state is LoginPasswordVisibilityChanged ? state.isObscure : true;

          return Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/budget.png",
                        color: Colors.white,
                        scale: 4,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "Welcome to Isecad",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: Form(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFieldWidget(
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) =>
                                EmailValidator.validate(value!)
                                    ? null
                                    : "Please enter a valid email",
                            mycontroller: _email,
                            hintText: "Email Address",
                            obscureText: false,
                          ),
                          const SizedBox(height: 16),
                          TextFieldWidget(
                            mycontroller: _password,
                            suffixIcon: GestureDetector(
                              onTap: () {
                                cubit.togglePasswordVisibility(isObscure);
                              },
                              child: Icon(
                                size: 20,
                                isObscure
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                            ),
                            hintText: "Password",
                            obscureText: isObscure,
                          ),
                          const SizedBox(height: 35),
                          ColoredButtonWidget(
                            buttonColor: Colors.black,
                            onPressed: () {
                              cubit.login(_email.text, _password.text);
                            },
                            text: "Login",
                            textColor: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
