import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dkan/components/card.dart';
import 'package:dkan/components/toast.dart';
import 'package:dkan/helpers/cubits/shop_cubit.dart';
import 'package:dkan/helpers/cubits/shop_state.dart';
import 'package:dkan/models/categories_model.dart';
import 'package:dkan/models/home_model.dart';
import 'package:dkan/models/product_model.dart';
import 'package:dkan/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductsScreen extends StatelessWidget {
  ProductsScreen({Key? key}) : super(key: key);

  CarouselController carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DkanCubit, ShopStates>(
        listener: (context, state) {
          if (state is ShopSuccessChangeFavoritiesState){
            if (!state.model.status!){
              showToast(text: state.model.message!, state: ToastState.ERROR);
            }
          }
        },
        builder: (context, state) {
          DkanCubit cubit = DkanCubit.get(context);
          return ConditionalBuilder(
            condition: cubit.homeModel != null,
            builder: (context) => productBuilder(cubit.homeModel,
                cubit.homeModel!.data!.products, cubit.categories!, context),
            fallback: (context) => const Center(
              child: Padding(
                padding: EdgeInsets.all(70.0),
                child: LinearProgressIndicator(),
              ),
            ),
          );
        });
  }

  Widget productBuilder(
      Home? homeModel, List<Product> products, Categories categories, context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.all(20.0),
            decoration: const BoxDecoration(
              color: Colors.blueGrey,
              boxShadow: [
                BoxShadow(
                  color: Colors.yellow,
                  offset: Offset(2, 1),
                  blurRadius: 7,
                )
              ],
            ),
            child: Container(
              color: Colors.white,
              child: CarouselSlider(
                items: homeModel!.data!.banners
                    .map((e) => FadeInImage(
                          image: NetworkImage('${e.image}',),
                          fit: BoxFit.cover,
                          width: double.infinity,
                          placeholder: const AssetImage('assets/images/logo3.png'),
                        ))
                    .toList(),
                options: CarouselOptions(
                  autoPlay: true,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  autoPlayInterval: const Duration(seconds: 4),
                  autoPlayAnimationDuration: const Duration(seconds: 1),
                  enableInfiniteScroll: true,
                  height: 200,
                  initialPage: 0,
                  reverse: false,
                  scrollDirection: Axis.horizontal,
                  viewportFraction: 1,
                ),
                carouselController: carouselController,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.categories.tr(),
                  style: GoogleFonts.lato().copyWith(fontSize: 20.0),
                ),
                const SizedBox(height: 10.0),
                Container(
                  height: 120.0,
                  child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) =>
                        buildCategorieItem(categories.data!.data[index]),
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 7.0),
                    itemCount: categories.data!.data.length,
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  LocaleKeys.products.tr(),
                  style: GoogleFonts.lato().copyWith(fontSize: 20.0),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 0,
              childAspectRatio: 1 / 1.7,
              children: List.generate(
                homeModel.data!.products.length,
                (index) => buildGridProduct(homeModel.data!.products[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGridProduct(Product model) => MyCard(product: model);

  Widget buildCategorieItem(Categore categore) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(1, 1),
                blurRadius: 7,
              )
            ],
            image: DecorationImage(
                image: 
                NetworkImage(categore.image!),
                fit: BoxFit.cover,
              ),
            borderRadius: BorderRadius.circular(20.0),
            color: const Color(0xFFF7F7F7),
          ),
          child: Container(
            width: 100.0,
            height: 100.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.black.withOpacity(0.4),
            ),
            child: Center(
              child: Text(
                categore.name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.lato().copyWith(
                  fontSize: 9.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      );
}
