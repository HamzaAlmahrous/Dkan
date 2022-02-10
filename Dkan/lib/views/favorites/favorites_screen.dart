import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dkan/components/card.dart';
import 'package:dkan/components/const.dart';
import 'package:dkan/helpers/cubits/shop_cubit.dart';
import 'package:dkan/helpers/cubits/shop_state.dart';
import 'package:dkan/models/favorit_model.dart';
import 'package:dkan/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DkanCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          DkanCubit cubit = DkanCubit.get(context);
          return ConditionalBuilder(
            condition: cubit.favoritesModel != null,
            builder: (context) => favoritesBuilder(cubit.favoritesModel!, context),
            fallback: (context) => const Center(
              child: Padding(
                padding: EdgeInsets.all(70.0),
                child: LinearProgressIndicator(),
              ),
            ),
          );
        });
  }

  Widget favoritesBuilder(FavoritesModel model, context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DefaultTextStyle(
                style: GoogleFonts.quicksand().copyWith(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                  color: defaultColor1,
                ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(LocaleKeys.favorites.tr(), speed: const Duration(milliseconds: 200)),
                  ],
                ),
              ),
              const Icon(Ionicons.heart, color: defaultColor1,),
            ],
          ),
          Container(
                padding: const EdgeInsets.all(10.0),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  childAspectRatio: 1/1.8,
                  children: List.generate(
                    model.data.data.length,
                    (index) => MyCard(product: model.data.data[index].product!),
                  ),
                ),
              ),
        ],
      ),
    );
  }
}