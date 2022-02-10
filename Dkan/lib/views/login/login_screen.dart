import 'dart:ui';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dkan/components/const.dart';
import 'package:dkan/components/default_button.dart';
import 'package:dkan/components/default_format_field.dart';
import 'package:dkan/components/default_text_button.dart';
import 'package:dkan/components/toast.dart';
import 'package:dkan/helpers/local/chache_helper.dart';
import 'package:dkan/translations/locale_keys.g.dart';
import 'package:dkan/views/login/cubit/login_cubit.dart';
import 'package:dkan/views/login/cubit/login_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DkanLogin extends StatelessWidget {
  DkanLogin({Key? key}) : super(key: key);
  var loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => DkanLoginCubit(),
      child: BlocConsumer<DkanLoginCubit, DkanLoginStates>(
        listener: (context, state) {
          if (state is DkanLoginSuccessState) {
            if (state.dkanLoginModel.status) {
              showToast(
                  text: state.dkanLoginModel.message,
                  state: ToastState.SUCCESS);
              CacheHelper.saveData(
                key: 'token',
                value: state.dkanLoginModel.data!.token,
              ).then((value) {
                token = state.dkanLoginModel.data!.token!;
                Navigator.pushNamedAndRemoveUntil(
                    context, '/home', (route) => false);
              });
            } else {
              showToast(
                  text: state.dkanLoginModel.message, state: ToastState.ERROR);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Form(
                    key: loginFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height/4,
                          child: const Image(
                            image: AssetImage('assets/images/reg.png'),
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          LocaleKeys.hi_text.tr(),
                          style: const TextStyle(
                              fontSize: 34.0,
                              letterSpacing: 3,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          LocaleKeys.login_message.tr(),
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.blueGrey,
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                          context: context,
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          label: LocaleKeys.email.tr(),
                          prefix: Icons.email_outlined,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your email';
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                            context: context,
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            label: LocaleKeys.password.tr(),
                            prefix: Icons.lock_outline,
                            suffix: DkanLoginCubit.get(context).suffix,
                            isPassword:
                                DkanLoginCubit.get(context).showPassword,
                            suffixPressed: () {
                              DkanLoginCubit.get(context)
                                  .changePasswordVisibility();
                            },
                            onSubmit: (value) {
                              if (loginFormKey.currentState!.validate()) {
                                DkanLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'password is too short';
                              }
                            }),
                        const SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! DkanLoginLoadingState,
                          builder: (context) => defaultButton(
                              gradient: const LinearGradient(colors: [
                                defaultColor1,
                                Colors.amber,
                                Colors.orange,
                              ]),
                              text: LocaleKeys.login.tr(),
                              isUpperCase: true,
                              function: () {
                                if (loginFormKey.currentState!.validate()) {
                                  DkanLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              }),
                          fallback: (context) => const Center(
                            child: Padding(
                              padding: EdgeInsets.all(70.0),
                              child: LinearProgressIndicator(),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        const Text('------------ or ------------',
                            style: TextStyle(fontSize: 20.0)),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultButton(
                            gradient: const LinearGradient(colors: [
                              Colors.orange,
                              Colors.amber,
                              defaultColor1,
                            ]),
                            text: LocaleKeys.register.tr(),
                            isUpperCase: true,
                            function: () {
                              Navigator.pushNamed(context, '/register');
                            }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
