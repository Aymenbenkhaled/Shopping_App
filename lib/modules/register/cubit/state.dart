import 'package:ishopit/models/login_model.dart';
import 'package:ishopit/models/register_model.dart';

abstract class ShopRegisterStates{}

class ShopRegisterInitialState extends ShopRegisterStates{}

class ShopRegisterLoadingState extends ShopRegisterStates{}

class ShopRegisterSuccessState extends ShopRegisterStates{
  final RegisterModel registerModel;
  ShopRegisterSuccessState(this.registerModel);
}

class ShopRegisterErrorState extends ShopRegisterStates{}

class ShopRegisterChangeVisibilityPasswordState extends ShopRegisterStates{}