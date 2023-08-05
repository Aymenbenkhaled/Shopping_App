import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ishopit/layout/cubit/cubit.dart';
import 'package:ishopit/layout/cubit/state.dart';
import 'package:ishopit/modules/login/shop_login_screen.dart';
import 'package:ishopit/shared/components/components.dart';
import 'package:ishopit/shared/network/local/cache_helper.dart';
import 'package:ishopit/shared/style/colors.dart';

class ShopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('IShopIt'),
            actions: [
              defaultTexButton(
                function: () {
                  CacheHelper.sharedPreferences!.remove('token').then(
                      (value) => navPushAndFinish(context, ShopLoginScreen()));
                },
                text: 'logout',
              )
            ],
          ),
          body: cubit.screensList[cubit.index],
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: defaultColor,
            currentIndex: cubit.index,
            onTap: (value) {
              cubit.ChangeBottomNav(value);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.production_quantity_limits),
                label: 'Products',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.category),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          ),
        );
      },
    );
  }
}
