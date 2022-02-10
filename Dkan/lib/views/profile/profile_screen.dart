import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dkan/components/const.dart';
import 'package:dkan/components/default_button.dart';
import 'package:dkan/helpers/cubits/shop_cubit.dart';
import 'package:dkan/helpers/cubits/shop_state.dart';
import 'package:dkan/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DkanCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          DkanCubit cubit = DkanCubit.get(context);
          return ConditionalBuilder(
            condition: cubit.user != null,
            builder: (context) => Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Ionicons.person_circle_outline,
                        size: 50.0,
                        color: defaultColor1,
                      ),
                      const SizedBox(width: 20),
                      Text(
                        cubit.user!.name!,
                        style: GoogleFonts.quicksand().copyWith(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30.0),
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40.0),
                      color: defaultColor3,
                    ),
                    child: Column(
                      children: [
                        DefaultTextStyle(
                          style: GoogleFonts.quicksand().copyWith(
                            fontSize: 26.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          child: AnimatedTextKit(
                            animatedTexts: [
                              TypewriterAnimatedText(LocaleKeys.info.tr(),
                                  speed: const Duration(milliseconds: 200)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        const Divider(
                          color: Colors.white,
                          thickness: 2.0,
                        ),
                        const SizedBox(height: 20.0),
                        Row(
                          children: [
                            const Icon(
                              Ionicons.mail_outline,
                              size: 30.0,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 20.0),
                            Text(
                              cubit.user!.email!,
                              style: const TextStyle(
                                fontSize: 24.0,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          children: [
                            const Icon(
                              Ionicons.phone_portrait_outline,
                              size: 30.0,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 20.0),
                            Text(
                              cubit.user!.phone!,
                              style: const TextStyle(
                                fontSize: 24.0,
                                color: Colors.white
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  const Spacer(),
                  defaultButton(
                      function: () {
                        Navigator.pushNamed(context, '/settings');
                      },
                      text: LocaleKeys.settings.tr(),
                      background: defaultColor3,
                    ),
                  const SizedBox(height: 20.0),
                  defaultButton(
                      function: () {
                        DkanCubit.get(context).logout(context);
                      },
                      text: LocaleKeys.logout.tr(),
                    ),
                ],
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
