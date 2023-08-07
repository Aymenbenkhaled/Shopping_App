import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ishopit/models/login_model.dart';
import 'package:ishopit/models/register_model.dart';
import 'package:ishopit/modules/login/cubit/state.dart';
import 'package:ishopit/modules/register/cubit/state.dart';
import 'package:ishopit/shared/components/components.dart';
import 'package:ishopit/shared/network/endpoints.dart';
import 'package:ishopit/shared/network/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  bool obscure = true;
  IconData icon = Icons.visibility_outlined;

  void ChangeVisibility() {
    obscure = !obscure;
    if (obscure) {
      icon = Icons.visibility_outlined;
    } else
      icon = Icons.visibility_off_outlined;
    emit(ShopRegisterChangeVisibilityPasswordState());
  }

  late RegisterModel registerModel;

  void RegisterUser({
    required String name,
    required String email,
    required String password,
    required String phone,
    context
  }) {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
      url: REGISTER,
      data: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      },
    ).then((value) {
      registerModel = RegisterModel.fromJson(value.data);
      print(registerModel.message);
      emit(ShopRegisterSuccessState(registerModel));
    }).catchError((onError){
      print(onError);
      emit(ShopRegisterErrorState());
    });
  }
}
