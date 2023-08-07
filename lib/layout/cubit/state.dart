import 'package:ishopit/models/add_delete_favorites_model.dart';
import 'package:ishopit/models/login_model.dart';

abstract class ShopStates{}

class ShopInitialState extends ShopStates{}

class ShopChangeBottomNavState extends ShopStates{}

class ShopGetHomeDataLoadingState extends ShopStates{}

class ShopGetHomeDataSuccessState extends ShopStates{}

class ShopGetHomeDataErrorState extends ShopStates{}

class ShopGetCategoriesDataLoadingState extends ShopStates{}

class ShopGetCategoriesDataSuccessState extends ShopStates{}

class ShopGetCategoriesDataErrorState extends ShopStates{}

class ShopAddOrDeleteFavoritesSuccessState extends ShopStates{
  final AddDeleteFavModel? addDeleteFavModel;
  ShopAddOrDeleteFavoritesSuccessState(this.addDeleteFavModel);
}

class ShopChangeFavoritesIconSuccessState extends ShopStates{}

class ShopAddOrDeleteFavoritesErrorState extends ShopStates{}

class ShopGetFavoritesSuccessState extends ShopStates{}

class ShopGetFavoritesErrorState extends ShopStates{}

class ShopGetUserDataLoadingState extends ShopStates{}

class ShopGetUserDataSuccessState extends ShopStates{

  final LoginModel? userData;

  ShopGetUserDataSuccessState(this.userData);
}

class ShopGetUserDataErrorState extends ShopStates{}

class ShopUpdateUserDataLoadingState extends ShopStates{}

class ShopUpdateUserDataSuccessState extends ShopStates{

  final LoginModel? userData;

  ShopUpdateUserDataSuccessState(this.userData);
}

class ShopUpdateUserDataErrorState extends ShopStates{}


class ShopChangeLangState extends ShopStates{}

class ShopChangeDarkLightState extends ShopStates{}