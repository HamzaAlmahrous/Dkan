import 'package:dkan/helpers/cubits/shop_cubit.dart';
import 'package:dkan/helpers/cubits/shop_state.dart';
import 'package:dkan/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

class LanguageScreen extends StatelessWidget {
  LanguageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DkanCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        DkanCubit cubit = DkanCubit.get(context);
        return SafeArea(
          child: Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Image(image: AssetImage('assets/images/lang.png')),
                    const SizedBox(height: 20.0),
                    Row(
                      children: [
                        const SizedBox(width: 10.0),
                        Text(
                          LocaleKeys.lang.tr(),
                          style: const TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                        const Icon(Ionicons.language_outline, size: 30.0),
                        const SizedBox(width: 20.0),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                              fixedSize: MaterialStateProperty.all(
                                  const Size(100, 50)),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              )),
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
                          child: const Text('العربية'),
                        ),
                        const SizedBox(width: 20.0),
                        ElevatedButton(
                          style: ButtonStyle(
                              fixedSize: MaterialStateProperty.all(
                                  const Size(100, 50)),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
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
                          child: const Text('English'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40.0),
                    FloatingActionButton(
                      child: const Icon(Icons.navigate_next),
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/login', (Route<dynamic> route) => false);
                      },
                    ),
                    const SizedBox(height: 10.0),
                    const SizedBox(
                        height: 150.0,
                        width: 300.0,
                        child:
                            Image(image: AssetImage('assets/images/logo1.png')))
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
