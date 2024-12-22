import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iscad/core/colors/app_colors.dart';
import 'package:iscad/core/common/buttons.dart';
import 'package:iscad/core/common/textfield.dart';
import 'package:iscad/features/home/presentation/screens/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  bool isObscuretext = true;
  bool _isButtonEnabled = false;
  final _formKey = GlobalKey<FormState>();

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
        body: Row(
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
                      key: _formKey,
                      onChanged: _isEnabled,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFieldWidget(
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(RegExp(r'\s')),
                            ],
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) =>
                                EmailValidator.validate(value!)
                                    ? null
                                    : "Please enter a valid email",
                            mycontroller: _email,
                            hintText: "Email Address ",
                            obscureText: false,
                          ),
                          const SizedBox(height: 16),
                          TextFieldWidget(
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(RegExp(r'\s')),
                            ],
                            mycontroller: _password,
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isObscuretext = !isObscuretext;
                                });
                              },
                              child: Icon(
                                size: 20,
                                isObscuretext
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                            ),
                            hintText: "Password",
                            obscureText: isObscuretext,
                          ),
                          const SizedBox(height: 35),
                          ColoredButtonWidget(
                            buttonColor: !_isButtonEnabled
                                ? AppColors.darkGrey
                                : Colors.black,
                            onPressed: _isButtonEnabled
                                ? () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const HomePage(),
                                        ));
                                    // if (_formKey.currentState!.validate()) {
                                    //   // add Logic Here
                                    // }
                                  }
                                : null,
                            text: "Login",
                            textColor: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  )),
            ),
          ],
        ));
  }

  void _isEnabled() {
    if (_email.text.isNotEmpty && _password.text.isNotEmpty) {
      _isButtonEnabled = true;
      setState(() {});
    } else {
      _isButtonEnabled = false;
      setState(() {});
    }
    setState(() {});
  }
}
