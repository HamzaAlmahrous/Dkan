import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dkan/components/card.dart';
import 'package:dkan/helpers/cubits/shop_cubit.dart';
import 'package:dkan/helpers/cubits/shop_state.dart';
import 'package:dkan/models/categories_detailes_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class CategoryDetaileScreen extends StatelessWidget {
  const CategoryDetaileScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DkanCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          DkanCubit cubit = DkanCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: ConditionalBuilder(
              condition: cubit.categoriesDetail != null,
              builder: (context) => categoryDetaileBuilder(cubit.categoriesDetail!, context),
              fallback: (context) => const Center(
                child: Padding(
                  padding: EdgeInsets.all(70.0),
                  child: LinearProgressIndicator(),
                ),
              ),
            ),
          );
        });
  }

  Widget categoryDetaileBuilder(CategoryDetail model, context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
                padding: const EdgeInsets.all(10.0),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  childAspectRatio: 1/1.8,
                  children: List.generate(
                    model.data.productData.length,
                    (index) => MyCard(product: model.data.productData[index]),
                  ),
                ),
              ),
        ],
      ),
    );
  }
}