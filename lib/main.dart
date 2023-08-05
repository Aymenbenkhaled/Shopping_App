import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ishopit/layout/cubit/cubit.dart';
import 'package:ishopit/layout/shop_layout.dart';
import 'package:ishopit/modules/login/shop_login_screen.dart';
import 'package:ishopit/modules/onboarding/onboarding_screen.dart';
import 'package:ishopit/shared/bloc_observer.dart';
import 'package:ishopit/shared/components/constants.dart';
import 'package:ishopit/shared/cubit/cubit.dart';
import 'package:ishopit/shared/cubit/states.dart';
import 'package:ishopit/shared/network/local/cache_helper.dart';
import 'package:ishopit/shared/network/remote/dio_helper.dart';
import 'package:ishopit/shared/style/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool skip = CacheHelper.getData(key: 'skip');
  String token = CacheHelper.getData(key: 'token');
  Widget widget;

  if (skip!=null) {
    if (token!=null) widget = ShopLayout();
    else widget = ShopLoginScreen();
  }else widget = OnboardingScreen();

  runApp(MyApp(skip: skip,startWidget: widget, token: token,));
}

class MyApp extends StatelessWidget {
  final bool skip;
  final Widget startWidget;
  final String token;

  MyApp({required this.skip, required this.startWidget, required this.token,});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit(),
        ),
        BlocProvider(create: (context) => ShopCubit()..GetHomeData(token: token),)
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: LightTheme,
            darkTheme: DarkTheme,
            themeMode: ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}
