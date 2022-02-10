import 'package:dkan/components/const.dart';
import 'package:dkan/helpers/cubits/shop_cubit.dart';
import 'package:dkan/helpers/cubits/shop_state.dart';
import 'package:dkan/models/product_model.dart';
import 'package:dkan/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductScreen extends StatelessWidget {
  PageController productImages = PageController();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  TextDirection? direction = lang == 'ar' ? TextDirection.RTL : TextDirection.LTR;

  ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DkanCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        Product? model = DkanCubit.get(context).product?.data;
        DkanCubit cubit = DkanCubit.get(context);
        return Scaffold(
          backgroundColor: const Color(0xFFF7F7F7),
          key: scaffoldKey,
          appBar: AppBar(
            backgroundColor: const Color(0xFFF7F7F7),
            systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: Color(0xFFF7F7F7),
                  statusBarIconBrightness: Brightness.dark,
                ),
          ),
          body: state is ProductLoadingState
              ? const Center(
                  child: Padding(
                  padding: EdgeInsets.all(100.0),
                  child: LinearProgressIndicator(),
                ))
              : Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF7F7F7),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              width: double.infinity,
                              child: Text(
                                '${model!.name}',
                                style: const TextStyle(
                                  fontSize: 24,
                                  color: defaultColor3,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              height: 400,
                              width: double.infinity,
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Stack(
                                alignment: AlignmentDirectional.topEnd,
                                children: [
                                  PageView.builder(
                                    controller: productImages,
                                    itemBuilder: (context, index) => Image(
                                      image: NetworkImage(
                                        model.images![index],
                                      ),
                                    ),
                                    itemCount: model.images!.length,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SmoothPageIndicator(
                              controller: productImages,
                              count: model.images!.length,
                              effect: const ExpandingDotsEffect(
                                  dotColor: Colors.grey,
                                  activeDotColor: defaultColor2,
                                  expansionFactor: 4,
                                  dotHeight: 7,
                                  dotWidth: 10,
                                  spacing: 10),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '${model.price} \$',
                                      style: const TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      padding: EdgeInsets.zero,
                                      icon: Icon(
                                        cubit.favorites[model.id] != false
                                            ? Ionicons.heart
                                            : Ionicons.heart_outline,
                                        color: Colors.red,
                                        size: 32.0,
                                      ),
                                      onPressed: () {
                                        cubit.changeFavorit(model.id!);
                                      },
                                    ),
                                  ],
                                ),
                                if (model.discount != 0)
                                  Row(
                                    children: [
                                      Text(
                                        '${model.oldPrice}',
                                        style: const TextStyle(
                                            color: Colors.grey,
                                            decoration:
                                                TextDecoration.lineThrough),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '${model.discount}% OFF',
                                        style:
                                            const TextStyle(color: Colors.red),
                                      ),
                                    ],
                                  ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  LocaleKeys.order_message.tr(),
                                  style: const TextStyle(color: Colors.grey),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(LocaleKeys.offer_details.tr(),
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.check_circle_outline,
                                        color: Colors.green),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(LocaleKeys.offer_details_message_1.tr()),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.check_circle_outline,
                                        color: Colors.green),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(LocaleKeys.offer_details_message_2.tr()),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(LocaleKeys.overview.tr(),
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text('${model.description}'),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
