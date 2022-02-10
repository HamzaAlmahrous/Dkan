import 'package:dkan/components/const.dart';
import 'package:dkan/components/toast.dart';
import 'package:dkan/helpers/local/chache_helper.dart';
import 'package:dkan/helpers/network/dio_helper.dart';
import 'package:dkan/helpers/network/end_points.dart';
import 'package:dkan/models/categories_detailes_model.dart';
import 'package:dkan/models/categories_model.dart';
import 'package:dkan/models/change_favorit_model.dart';
import 'package:dkan/models/favorit_model.dart';
import 'package:dkan/models/home_model.dart';
import 'package:dkan/models/product_model.dart';
import 'package:dkan/models/user.dart';
import 'package:dkan/views/categories/categories_screen.dart';
import 'package:dkan/views/favorites/favorites_screen.dart';
import 'package:dkan/views/home/products_screen.dart';
import 'package:dkan/views/profile/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

import 'shop_state.dart';

class DkanCubit extends Cubit<ShopStates> {
  DkanCubit() : super(InitialState());

  static DkanCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Icon> icons = [
    const Icon(Ionicons.home),
    const Icon(Ionicons.apps_outline),
    const Icon(Ionicons.heart_outline),
    const Icon(Ionicons.person_circle_outline),
  ];

  List<Widget> screens = [
    ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    const ProfileScreen(),
  ];

  void changeScreen(int index) {
    if (currentIndex == 0) {
      icons[currentIndex] = const Icon(Ionicons.home_outline);
    } else if (currentIndex == 1) {
      icons[currentIndex] = const Icon(Ionicons.apps_outline);
    } else if (currentIndex == 2) {
      icons[currentIndex] = const Icon(Ionicons.heart_outline);
    } else {
      icons[currentIndex] = const Icon(Ionicons.person_circle_outline);
    }
    currentIndex = index;
    if (currentIndex == 0) {
      icons[currentIndex] = const Icon(Ionicons.home);
    } else if (currentIndex == 1) {
      icons[currentIndex] = const Icon(Ionicons.apps);
    } else if (currentIndex == 2) {
      icons[currentIndex] = const Icon(Ionicons.heart);
    } else {
      icons[currentIndex] = const Icon(Ionicons.person_circle);
    }
    emit(ChangeScreenState());
  }

  Home? homeModel;

  Map<int, bool> favorites = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(url: HOME, token: token).then((value) {
      favorites = {};

      homeModel = Home.fromJson(value.data);

      for (var element in homeModel!.data!.products) {
        favorites.addAll({element.id! : element.inFavorites!});
      }

      emit(ShopSuccessHomeDataState());

    }).catchError((error) {
      print(error);
        emit(ShopErrorHomeDataState());

    });
  }

  Categories? categories;

  void getCategoryData() {
    emit(ShopLoadingCategoriesState());
    DioHelper.getData(url: GET_GATEGOIES).then((value){

      categories = Categories.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
      
    }).catchError((error){
      emit(ShopErrorCategoriesState());
      print(error.toString());
    });
  }

  ChangeFavorit? model;

  void changeFavorit(int productId){
    
    favorites[productId] = !favorites[productId]!;
    emit(ShopChangeFavoritiesState());

    DioHelper.postData(
      url: FAVORITES, 
      data: {
        'product_id' : productId
      },
      token: token!,
    ).then((value) { 
      model = ChangeFavorit.fromJson(value.data);

      if(!model!.status!){
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavorites();
      }

      emit(ShopSuccessChangeFavoritiesState(model!));

    }).catchError((error){
      favorites[productId] = !favorites[productId]!;
      emit(ShopErrorChangeFavoritState());
      print(error);
    });

  }

  FavoritesModel? favoritesModel;

  void getFavorites(){
    emit(ShopLoadingGetFavoritesState());

    DioHelper.getData(
      url: FAVORITES, 
      token: token,
    ).then((value) { 

      favoritesModel = FavoritesModel.fromJson(value.data);

      emit(ShopSuccessGetFavoritesState());

    }).catchError((error){

      emit(ShopErrorGetFavoritesState());
      print(error);
    });

  }

  User? user;

  void getUserData(){
    emit(ShopLoadingUserDataState());

    DioHelper.getData(
      url: PROFILE, 
      token: token,
    ).then((value) { 
      user = User.fromJson(value.data['data']);
      emit(ShopSuccessUserDataState());
    }).catchError((error){
      emit(ShopErrorUserDataState());
      print(error);
    });
  }

  void updateUserData({required String name, required String phone, required String email}){
    emit(ShopLoadingUpdateUserDataState());

    DioHelper.putData(
      url: UPDATE_PROFILE,
      data: {
        'email': email,
        'phone': phone,
        'name': name,
      }, 
      token: token!,
    ).then((value) { 
      user = User.fromJson(value.data['data']);
      emit(ShopSuccessUpdateUserDataState());
    }).catchError((error){
      emit(ShopErrorUpdateUserDataState());
      print(error);
    });
  }

  void logout(context) {
    DioHelper.postData(url: LOGOUT, data: {}, token: token!
    ).then((value){
      showToast(text: value.data['message'], state: ToastState.SUCCESS);
      CacheHelper.removeData(key: 'token').then((value){
        if(value){
          Navigator.pushNamedAndRemoveUntil(
            context, '/login', (Route<dynamic> route) => false);
        }
      });
    }).catchError((error){
      showToast(text: 'ERROR', state: ToastState.ERROR);
      emit(ShopErrorUserDataState());
    });
  }

  ProductDetails? product;

  void getProduct({required int id, context }){
    product = null;
    emit(ProductLoadingState());
    DioHelper.getData(
      url: 'products/$id',
      token: token,
    ).then((value){
      print(value.data);
      product = ProductDetails.fromJson(value.data);
      emit(ProductSuccessState());
      
      print(product!.data!.image);
    }).catchError((error){
      print(error);
      emit(ProductErrorState());
    });
  }

  CategoryDetail? categoriesDetail;
  void getCategoriesDetailData( int? categoryID ) {
    emit(CategoryDetailsLoadingState());
    DioHelper.getData(
      url: 'categories/$categoryID',
    ).then((value){
      categoriesDetail = CategoryDetail.fromJson(value.data);
      print('categories Detail '+categoriesDetail!.status.toString());
      emit(CategoryDetailsSuccessState());
    }).catchError((error){
      emit(CategoryDetailsErrorState());
      print(error.toString());
    });
  }

  List<bool> isSelected = [lang == 'ar' ? true : false ,lang == 'en' ? true : false ];
  void changeLanguage(String lang1){
    lang = lang1;
    CacheHelper.saveData(key: 'lang', value: lang1 );
    emit(ChangeLanguageState());
  }

}
