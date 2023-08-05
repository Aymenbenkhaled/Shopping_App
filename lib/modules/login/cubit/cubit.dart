import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ishopit/modules/login/cubit/state.dart';
import 'package:ishopit/shared/network/endpoints.dart';
import 'package:ishopit/shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  ShopLoginCubit get(context) => BlocProvider.of(context);

  bool obscure = true;
  IconData icon = Icons.visibility_outlined;

  void ChangeVisibility() {
    obscure = !obscure;
    if (obscure) {
      icon = Icons.visibility_outlined;
    } else
      icon = Icons.visibility_off_outlined;
    emit(ShopLoginChangeVisibilityPasswordState());
  }

  void LoginUser({
    required String email,
    required String password,
  }) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      print(value.data);
      emit(ShopLoginSuccessState());
    }).catchError((onError){
      print(onError);
      emit(ShopLoginErrorState());
    });
  }
}
