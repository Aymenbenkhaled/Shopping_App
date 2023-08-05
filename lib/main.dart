import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ishopit/layout/shop_layout.dart';
import 'package:ishopit/modules/onboarding/onboarding_screen.dart';
import 'package:ishopit/shared/bloc_observer.dart';
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
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit(),
        ),
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
            home: OnboardingScreen(),
          );
        },
      ),
    );
  }
}
