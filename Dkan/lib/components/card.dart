import 'package:dkan/components/const.dart';
import 'package:dkan/helpers/cubits/shop_cubit.dart';
import 'package:dkan/helpers/cubits/shop_state.dart';
import 'package:dkan/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

class MyCard extends StatelessWidget {
  MyCard({
    required this.product,
    this.isSearch = false,
    Key? key,
  }) : super(key: key);

  Product product;
  bool isSearch;
  

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DkanCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        DkanCubit cubit = DkanCubit.get(context);
        return FlatButton(
          onPressed: () {
            DkanCubit.get(context).getProduct(id: product.id!);

            Navigator.pushNamed(context, '/product');
          },
          child: Container(
            padding: const EdgeInsets.only(top: 1.0, bottom: 1.0),
            margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.all(5),
                      child: FadeInImage(
                        width: double.infinity,
                        height: 200.0,
                        image: NetworkImage(product.image!),
                        placeholder: const AssetImage('assets/images/logo3.png'),
                      ),
                    ),
                    if (product.discount != 0 && !isSearch)
                      Container(
                        color: Colors.red,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5.0,
                        ),
                        child: Text(
                          'DISCOUNT ${product.discount} %',
                          style: const TextStyle(
                            fontSize: 12.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.lato().copyWith(
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${product.price.round()}',
                                style: GoogleFonts.lato().copyWith(
                                  color: defaultColor3,
                                  fontSize: 14.0,
                                ),
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              if (product.discount != 0 && !isSearch)
                                Text(
                                  '${product.oldPrice.round()}',
                                  style: GoogleFonts.lato().copyWith(
                                    color: const Color(0xFF344CB7),
                                    decoration: TextDecoration.lineThrough,
                                    fontSize: 14.0,
                                  ),
                                ),
                            ],
                          ),
                          const Spacer(),
                          IconButton(
                            padding: EdgeInsets.zero,
                            icon: Icon(
                              cubit.favorites[product.id] != false
                                  ? Ionicons.heart
                                  : Ionicons.heart_outline,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              cubit.changeFavorit(product.id!);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
