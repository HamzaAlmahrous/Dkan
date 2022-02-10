import 'package:dkan/components/const.dart';
import 'package:dkan/helpers/cubits/shop_cubit.dart';
import 'package:dkan/helpers/cubits/shop_state.dart';
import 'package:dkan/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DkanLayout extends StatelessWidget {
  const DkanLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DkanCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = DkanCubit.get(context);
        if(DkanCubit.get(context).user == null){
          DkanCubit.get(context).getUserData();
        }
        return Scaffold(
          appBar: AppBar(
            title: Container(
              height: 100.0,
              child: Image(image: AssetImage('assets/images/logo1.png'),fit: BoxFit.cover,)),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/search');
                },
                icon: const Icon(Icons.search),
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              cubit.changeScreen(index);
            },
            currentIndex: cubit.currentIndex,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                icon: cubit.icons[0],
                label: LocaleKeys.home.tr(),
                
              ),
              BottomNavigationBarItem(
                icon: cubit.icons[1],
                label: LocaleKeys.categories.tr(),
              ),
              BottomNavigationBarItem(
                icon: cubit.icons[2],
                label: LocaleKeys.favorites.tr(),
              ),
              BottomNavigationBarItem(
                icon: cubit.icons[3],
                label: LocaleKeys.profile.tr(),
              ),
            ],
          ),
        );
      },
    );
  }
}
