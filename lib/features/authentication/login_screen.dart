import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sca_shop/shared/colors.dart';
import 'package:sca_shop/shared/constants.dart';
import 'package:sca_shop/shared/navigation/app_router.dart';
import 'package:sca_shop/shared/navigation/route_strings.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          child: Padding(padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  "Login",
                  style: style.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                AppTextInput(
                  controller: emailController,
                  label: 'Email',
                  inputFormatter: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z@._-]'))
                  ],
                  validator: (a) {
                    if (!emailRegex.hasMatch(a ?? "")) {
                      return "Inavlid email";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                AppTextInput(
                  controller: emailController,
                  label: 'Password',
                  inputFormatter: [
                     FilteringTextInputFormatter.deny(RegExp(r' '))
                  ],
                  validator: (a) => (a ?? "").isNotEmpty ? null : 'Invalid Password',
                ),
                 const SizedBox(
                  height: 50,
                ),
                AppButton(text: 'Login'),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                        text: TextSpan(
                      children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              AppRouter.pushReplace(
                                  AppRouteStrings.registerScreen);
                            },
                          text: " Register",
                          style: style.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: AppColors.appColor),
                        )
                      ],
                      text: "Don't have an account?",
                      style: style.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    )),
                  ],
                )
            ],
          ),
          )
          )
        ),
    );
  }
}