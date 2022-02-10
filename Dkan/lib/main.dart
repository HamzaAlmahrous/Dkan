import 'package:dkan/components/const.dart';
import 'package:dkan/components/themes.dart';
import 'package:dkan/translations/codegen_loader.g.dart';
import 'package:dkan/views/categories/category_detailes_screen.dart';
import 'package:dkan/views/language/language_screen.dart';
import 'package:dkan/views/login/login_screen.dart';
import 'package:dkan/views/product_detailes.dart/product_detailes_screen.dart';
import 'package:dkan/views/profile/profile_screen.dart';
import 'package:dkan/views/search/search_screen.dart';
import 'package:dkan/views/settings/settings_screen.dart';
import 'package:dkan/views/shop_layout/dkan_layout.dart';
import 'package:dkan/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dkan/views/register/register_screen.dart';
import 'helpers/bloc_observer.dart';
import 'helpers/cubits/shop_cubit.dart';
import 'helpers/cubits/shop_state.dart';
import 'helpers/local/chache_helper.dart';
import 'helpers/network/dio_helper.dart';
import 'package:easy_localization/easy_localization.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await CacheHelper.init();
  DioHelper.init();

  bool? onBoarding;
  onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  lang = CacheHelper.getData(key: 'lang');
  lang ??= 'en';

  print(onBoarding);
  print(token);
  print(lang);

  Widget startWidget = Wrapper.start(token: token, onBarding: onBoarding);

  BlocOverrides.runZoned(
    () {
      runApp(EasyLocalization(
        path: 'assets/translations',
        supportedLocales: const [
          Locale('en'),
          Locale('ar'),
        ],
        assetLoader: const CodegenLoader(),
        fallbackLocale: const Locale('en'),
        child: MyApp(startWidget: startWidget),
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  const MyApp({Key? key, required this.startWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => DkanCubit()
              ..getHomeData()
              ..getCategoryData()
              ..getFavorites()
              ..getUserData()),
      ],
      child: BlocConsumer<DkanCubit, ShopStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              debugShowCheckedModeBanner: false,
              theme: lightTheme(),
              darkTheme: darkTheme(),
              themeMode: ThemeMode.light,
              home: startWidget,
              routes: {
                '/login': (context) => DkanLogin(),
                '/register': (context) => RegisterScreen(),
                '/profile': (context) => const ProfileScreen(),
                '/home': (context) => const DkanLayout(),
                '/search': (context) => SearchScreen(),
                '/settings': (context) => SettingsScreen(),
                '/product': (context) => ProductScreen(),
                '/category': (context) => const CategoryDetaileScreen(),
                '/lang': (context) => LanguageScreen(),
              },
            );
          }),
    );
  }
}
