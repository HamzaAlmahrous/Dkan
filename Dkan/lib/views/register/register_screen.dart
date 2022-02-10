import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dkan/components/const.dart';
import 'package:dkan/components/default_button.dart';
import 'package:dkan/components/default_format_field.dart';
import 'package:dkan/components/toast.dart';
import 'package:dkan/helpers/local/chache_helper.dart';
import 'package:dkan/translations/locale_keys.g.dart';
import 'package:dkan/views/register/cubit/register_cubit.dart';
import 'package:dkan/views/register/cubit/register_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  var registerFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var phoneController = TextEditingController();
    var nameController = TextEditingController();
    var passwordController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            if (state.registerModel.status) {
              showToast(
                  text: state.registerModel.message, state: ToastState.SUCCESS);
              CacheHelper.saveData(
                key: 'token',
                value: state.registerModel.data!.token,
              ).then((value) {
                token = state.registerModel.data!.token!;
                Navigator.pushNamedAndRemoveUntil(
                    context, '/home', (route) => false);
              });
            } else {
              showToast(
                  text: state.registerModel.message, state: ToastState.ERROR);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: registerFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height/3,
                          child: const Image(
                            image: AssetImage('assets/images/log.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(
                          LocaleKeys.register.tr(),
                          style: const TextStyle(
                              fontSize: 34.0,
                              letterSpacing: 3,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          LocaleKeys.register_message.tr(),
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
                          controller: nameController,
                          keyboardType: TextInputType.emailAddress,
                          label: LocaleKeys.name.tr(),
                          prefix: Ionicons.person_circle_outline,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your name';
                            }
                          },
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
                          height: 30.0,
                        ),
                        defaultFormField(
                          context: context,
                          controller: phoneController,
                          keyboardType: TextInputType.emailAddress,
                          label: LocaleKeys.phone.tr(),
                          prefix: Icons.phone,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your phone number';
                            }
                          },
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                            context: context,
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            label: LocaleKeys.password.tr(),
                            prefix: Icons.lock_outline,
                            suffix: RegisterCubit.get(context).suffix,
                            isPassword:
                                RegisterCubit.get(context).showPassword,
                            suffixPressed: () {
                              RegisterCubit.get(context)
                                  .changePasswordVisibility();
                            },
                            onSubmit: (value) {
                              if (registerFormKey.currentState!
                                  .validate()) {}
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
                          condition: state is! RegisterLoadingState,
                          builder: (context) => defaultButton(
                              gradient: const LinearGradient(colors: [
                                defaultColor1,
                                Colors.amber,
                                Colors.orange,
                              ]),
                              text: LocaleKeys.register.tr(),
                              isUpperCase: true,
                              function: () {
                                if (registerFormKey.currentState!.validate()) {
                                  RegisterCubit.get(context).userRegister(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    name: nameController.text,
                                    phone: phoneController.text,
                                  );
                                }
                              }),
                          fallback: (context) => const Center(
                            child: Padding(
                              padding: EdgeInsets.all(100.0),
                              child: LinearProgressIndicator(),
                            ),
                          ),
                        ),
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
