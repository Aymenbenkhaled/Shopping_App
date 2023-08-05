import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ishopit/shared/cubit/states.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit()
      : super(
          AppInitialState(),
        );


  static AppCubit get(context) => BlocProvider.of(context);
  bool darkLight = true;
  bool b = false;
  bool isVisible = true;

  void changeVisibility() {
    isVisible = !isVisible;
    emit(AppChangePswVisibilityState());
  }


  IconData fabIcon = Icons.edit;
  bool bol = false;

  void ChangeBottomSheetState({
    required IconData icon,
    required bool boll,
  }) {
    bol = boll;
    fabIcon = icon;
    emit(AppChageBottomSheetState());
  }

}
