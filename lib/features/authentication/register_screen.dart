import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sca_shop/shared/colors.dart';
import 'package:sca_shop/shared/constants.dart';
import 'package:sca_shop/shared/navigation/app_router.dart';
import 'package:sca_shop/shared/navigation/route_strings.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
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
                  "Register",
                  style: style.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                AppTextInput(
                  controller: nameController,
                  label: 'Password',
                  inputFormatter: [
                     FilteringTextInputFormatter.deny(RegExp(r' '))
                  ],
                  validator: (a) => (a ?? "").length >3 ? null : 'Invalid Password',
                ),
                 const SizedBox(
                  height: 20,
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
                  controller: passwordController,
                  label: 'Password',
                  inputFormatter: [
                     FilteringTextInputFormatter.deny(RegExp(r' '))
                  ],
                  validator: (a) => (a ?? "").isNotEmpty ? null : 'Invalid Password',
                ),
                 const SizedBox(
                  height: 50,
                ),
                AppButton(text: 'Register'),
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
                                  AppRouteStrings.loginScreen);
                            },
                          text: " Login",
                          style: style.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: AppColors.appColor),
                        )
                      ],
                      text: "Already have an account?",
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