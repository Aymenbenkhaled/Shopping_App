import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ishopit/layout/cubit/state.dart';
import 'package:ishopit/models/home_model.dart';
import 'package:ishopit/modules/categories/categories_screen.dart';
import 'package:ishopit/modules/favorites/favorites_screen.dart';
import 'package:ishopit/modules/products/products_screen.dart';
import 'package:ishopit/modules/settings/settings_screen.dart';
import 'package:ishopit/shared/components/constants.dart';
import 'package:ishopit/shared/network/endpoints.dart';
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

  void GetHomeData() {
    emit(ShopGetHomeDataLoadingState());
    DioHelper.getData(url: HOME, token: token)
        .then((value) {
          //print(value.data);
          homeModel = HomeModel.fromJson(value.data);
          emit(ShopGetHomeDataSuccessState());
    })
        .catchError((onError) {
          print(onError);
          emit(ShopGetHomeDataErrorState());
    });
  }
}
