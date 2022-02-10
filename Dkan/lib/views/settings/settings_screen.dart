import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dkan/components/const.dart';
import 'package:dkan/components/default_button.dart';
import 'package:dkan/components/default_format_field.dart';
import 'package:dkan/helpers/cubits/shop_cubit.dart';
import 'package:dkan/helpers/cubits/shop_state.dart';
import 'package:dkan/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);
  var updateFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var phoneController = TextEditingController();
    var nameController = TextEditingController();
    return BlocConsumer<DkanCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          DkanCubit cubit = DkanCubit.get(context);
          emailController.text = cubit.user!.email!;
          phoneController.text = cubit.user!.phone!;
          nameController.text = cubit.user!.name!;
          return ConditionalBuilder(
            condition: cubit.user != null,
            builder: (context) => Scaffold(
              appBar: AppBar(),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: updateFormKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              LocaleKeys.settings.tr(),
                              style: const TextStyle(fontSize: 34.0),
                            ),
                            const SizedBox(width: 20.0),
                            const Icon(
                              Icons.settings,
                              size: 40.0,
                            ),
                          ],
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
                            return null;
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
                            return null;
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
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoadingUpdateUserDataState,
                          builder: (context) => defaultButton(
                              gradient: const LinearGradient(colors: [
                                defaultColor1,
                                Colors.amber,
                                Colors.orange,
                              ]),
                              text: LocaleKeys.update_profile.tr(),
                              isUpperCase: true,
                              function: () {
                                if (updateFormKey.currentState!.validate()) {
                                  cubit.updateUserData(
                                    email: emailController.text,
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
                        const SizedBox(height: 30.0),
                        Column(
                          children: [
                            Row(
                              children: [
                                const SizedBox(width: 10.0),
                                Text(
                                  LocaleKeys.lang.tr(),
                                  style: const TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Icon(Ionicons.language_outline,
                                    size: 30.0),
                                const SizedBox(width: 20.0),
                              ],
                            ),
                            const SizedBox(height: 20.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                      ),
                                      fixedSize: MaterialStateProperty.all(
                                          const Size(100, 50))),
                                  onPressed: () async {
                                    cubit.changeLanguage('ar');
                                    cubit.isSelected[0] = true;
                                    cubit.isSelected[1] = false;
                                    await context.setLocale(const Locale('ar'));

                                    cubit.categories = null;
                                    cubit.homeModel = null;
                                    cubit.favoritesModel = null;
                                    cubit.favorites = {};
                                    cubit.getHomeData();
                                    cubit.getCategoryData();
                                    cubit.getFavorites();
                                  },
                                  child: const Text('العربية',
                                      style: TextStyle(color: Colors.white)),
                                ),
                                const SizedBox(width: 20.0),
                                ElevatedButton(
                                  style: ButtonStyle(
                                      fixedSize: MaterialStateProperty.all(
                                          const Size(100, 50)),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                      )),
                                  onPressed: () async {
                                    cubit.changeLanguage('er');
                                    cubit.isSelected[1] = true;
                                    cubit.isSelected[0] = false;
                                    await context.setLocale(const Locale('en'));

                                    cubit.categories = null;
                                    cubit.homeModel = null;
                                    cubit.favoritesModel = null;
                                    cubit.favorites = {};
                                    cubit.getHomeData();
                                    cubit.getCategoryData();
                                    cubit.getFavorites();
                                  },
                                  child: const Text('English',
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            fallback: (context) => const Center(
              child: Padding(
                padding: EdgeInsets.all(70.0),
                child: LinearProgressIndicator(),
              ),
            ),
          );
        });
  }
}
