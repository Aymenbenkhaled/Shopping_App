import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ishopit/layout/cubit/state.dart';
import 'package:ishopit/models/add_delete_favorites_model.dart';
import 'package:ishopit/models/categories_model.dart';
import 'package:ishopit/models/favorites_model.dart';
import 'package:ishopit/models/home_model.dart';
import 'package:ishopit/models/login_model.dart';
import 'package:ishopit/modules/categories/categories_screen.dart';
import 'package:ishopit/modules/favorites/favorites_screen.dart';
import 'package:ishopit/modules/products/products_screen.dart';
import 'package:ishopit/modules/settings/settings_screen.dart';
import 'package:ishopit/shared/components/constants.dart';
import 'package:ishopit/shared/network/endpoints.dart';
import 'package:ishopit/shared/network/local/cache_helper.dart';
import 'package:ishopit/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int index = 0;

  List<Widget> screensList = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void ChangeBottomNav(value) {
    index = value;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;

  Map<int?, bool?> favoorites = {};

  void GetHomeData() {
    emit(ShopGetHomeDataLoadingState());
    DioHelper.getData(url: HOME, token: token, lang: lang).then((value) {
      //print(value.data);
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products!.forEach(
          (element) => favoorites.addAll({element.id: element.in_favorites}));
      emit(ShopGetHomeDataSuccessState());
    }).catchError((onError) {
      print(onError);
      emit(ShopGetHomeDataErrorState());
    });
  }

  CategoriesModel? categoriesModel;

  void GetCategories() {
    emit(ShopGetCategoriesDataLoadingState());
    DioHelper.getData(url: GET_CATEGORIES, lang: lang).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      //print(categoriesModel!.data!.data!.length);
      //print(categoriesModel!.data!.data![0].name);

      emit(ShopGetCategoriesDataSuccessState());
    }).catchError((onError) {
      print(onError);
      emit(ShopGetCategoriesDataErrorState());
    });
  }

  AddDeleteFavModel? addDeleteFavModel;

  void AddOrDeleteFavorites(product_id) {
    favoorites[product_id] == false
        ? favoorites[product_id] = true
        : favoorites[product_id] = false;
    emit(ShopChangeFavoritesIconSuccessState());
    DioHelper.postData(
            url: FAVORITES, data: {'product_id': product_id}, token: token)
        .then((value) {
      addDeleteFavModel = AddDeleteFavModel.fromJson(value.data);
      if (addDeleteFavModel!.status == false) {
        favoorites[product_id] == false
            ? favoorites[product_id] = true
            : favoorites[product_id] = false;
      } else {
        GetFavorites();
      }
      //print(favoorites[product_id]);
      emit(ShopAddOrDeleteFavoritesSuccessState(addDeleteFavModel));
    }).catchError((onError) {
      favoorites[product_id] == false
          ? favoorites[product_id] = true
          : favoorites[product_id] = false;
      print(onError);
      emit(ShopAddOrDeleteFavoritesErrorState());
    });
  }

  FavoritesModel? favoritesModel;

  void GetFavorites() {
    DioHelper.getData(url: FAVORITES, lang: lang, token: token).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(ShopGetFavoritesSuccessState());
    }).catchError((onError) {
      print(onError);
      emit(ShopGetFavoritesErrorState());
    });
  }

  LoginModel? userData;

  void GetUserData() {
    emit(ShopGetUserDataLoadingState());
    DioHelper.getData(url: PROFILE, lang: lang, token: token).then((value) {
      userData = LoginModel.fromJson(value.data);
      //print(userData!.data!.name);
      emit(ShopGetUserDataSuccessState(userData));
    }).catchError((onError) {
      print(onError);
      emit(ShopGetUserDataErrorState());
    });
  }

  Map<String, dynamic> data = {};

  void UpdateUserData(name, email, phone) {
    // data['name'] = name;
    // data['email'] = email;
    // data['phone'] = phone;

    emit(ShopUpdateUserDataLoadingState());
    DioHelper.putData(url: UPDATE, lang: lang, token: token, data: {
      'name': name,
      'email': email,
      'phone': phone,
    }).then((value) {
      userData = LoginModel.fromJson(value.data);
      print(userData!.data!.name);
      emit(ShopGetUserDataSuccessState(userData));
    }).catchError((onError) {
      print(onError);
      emit(ShopGetUserDataErrorState());
    });
  }

  void changeLang() {
    if (lang == 'en') {
      lang = 'ar';
    } else
      lang = 'en';
    CacheHelper.saveData(key: 'lang', value: lang);
    GetHomeData();
    GetCategories();
    GetFavorites();
    emit(ShopChangeLangState());
  }

  bool? darkLight ;
  //IconData DarkLightIcon = Icons.dark_mode;

  void changeDarkLight() {

    // if (darkLight) {
    //   DarkLightIcon = Icons.dark_mode;
    // }else DarkLightIcon = Icons.dark_mode_outlined;
    CacheHelper.saveData(key: 'DarkLight', value: true)
        .then((value) => emit(ShopChangeDarkLightState()));
  }
}
