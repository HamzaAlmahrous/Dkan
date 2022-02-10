import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dkan/components/const.dart';
import 'package:dkan/helpers/cubits/shop_cubit.dart';
import 'package:dkan/helpers/cubits/shop_state.dart';
import 'package:dkan/models/categories_model.dart';
import 'package:dkan/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DkanCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          DkanCubit cubit = DkanCubit.get(context);
          return ConditionalBuilder(
            condition: cubit.homeModel != null,
            builder: (context) => categoriesBuilder(cubit.categories!, context),
            fallback: (context) => const Center(
              child: Padding(
                padding: EdgeInsets.all(70.0),
                child: LinearProgressIndicator(),
              ),
            ),
          );
        });
  }

  Widget categoriesBuilder(Categories categories, context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          DefaultTextStyle(
                style: GoogleFonts.quicksand().copyWith(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                  color: defaultColor1,
                ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(LocaleKeys.categories.tr(), speed: const Duration(milliseconds: 200)),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
          ListView.separated(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildCategorieItem(categories.data!.data[index], context, categories.data!.data[index].id), 
            separatorBuilder: (context, index) => const SizedBox(height: 20.0), 
            itemCount: categories.data!.data.length,
          ),
        ],
      ),
    );
  }

  Widget buildCategorieItem(Categore categore, context, int? id) => Padding(
          padding: const EdgeInsets.all(10.0),
          child: FlatButton(
            onPressed: (){
                DkanCubit.get(context).getCategoriesDetailData(id);

            Navigator.pushNamed(context, '/category');
          

            },
            child: Container(
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(1, 1),
                    blurRadius: 7,
                  )
                ],
                borderRadius: BorderRadius.circular(20.0),
                color: const Color(0xFFF7F7F7),
              ),
              child: Row(
                children: [
                  Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                              ),
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.all(5),
                        child: FadeInImage(
                          width: 100.0,
                          height: 100.0,
                          placeholder: const AssetImage('assets/images/logo3.png'),
                          image: NetworkImage(categore.image!),
                        ),
                      ),
                      const SizedBox(width: 20.0),
                  Expanded(
                    flex: 5,
                    child: Text(
                      categore.name!.toUpperCase(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.lato().copyWith(
                        fontSize: 15.0,  
                      ),
                    ),
                  ),
                  const Spacer(),
                  IconButton(onPressed: (){}, icon: const Icon(Ionicons.arrow_forward_outline)),
                ],
              ),
            ),
          ),
        );

}