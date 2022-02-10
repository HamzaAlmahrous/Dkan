import 'package:dkan/models/change_favorit_model.dart';

abstract class ShopStates {}

///General States
class InitialState extends ShopStates {}

class ChangeModeState extends ShopStates {}

class ChangeScreenState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {}

class ShopLoadingCategoriesState extends ShopStates {}

class ShopSuccessCategoriesState extends ShopStates {}

class ShopErrorCategoriesState extends ShopStates {}

class ShopChangeFavoritiesState extends ShopStates {}

class ShopSuccessChangeFavoritiesState extends ShopStates {
    final ChangeFavorit model;
    ShopSuccessChangeFavoritiesState(this.model);
}

class ShopErrorChangeFavoritState extends ShopStates {}

class ShopLoadingGetFavoritesState extends ShopStates {}

class ShopSuccessGetFavoritesState extends ShopStates {}

class ShopErrorGetFavoritesState extends ShopStates {}

class ShopLoadingUserDataState extends ShopStates {}

class ShopSuccessUserDataState extends ShopStates {}

class ShopErrorUserDataState extends ShopStates {}

class ShopLoadingUpdateUserDataState extends ShopStates {}

class ShopSuccessUpdateUserDataState extends ShopStates {}

class ShopErrorUpdateUserDataState extends ShopStates {}

class ProductInitialState extends ShopStates {}

class ProductLoadingState extends ShopStates {}

class ProductSuccessState extends ShopStates {}

class ProductErrorState extends ShopStates {}

class CategoryDetailsLoadingState extends ShopStates {}

class CategoryDetailsSuccessState extends ShopStates {}

class CategoryDetailsErrorState extends ShopStates {}

class ChangeLanguageState extends ShopStates {}