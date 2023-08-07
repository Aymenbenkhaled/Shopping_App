import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ishopit/layout/cubit/cubit.dart';
import 'package:ishopit/layout/cubit/state.dart';
import 'package:ishopit/modules/login/shop_login_screen.dart';
import 'package:ishopit/modules/search/search_screen.dart';
import 'package:ishopit/modules/settings/settings_screen.dart';
import 'package:ishopit/shared/components/components.dart';
import 'package:ishopit/shared/network/local/cache_helper.dart';
import 'package:ishopit/shared/style/colors.dart';

class ShopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopAddOrDeleteFavoritesSuccessState) {
          if (state.addDeleteFavModel!.status == false) {
            CustomFlutterToast(
              context: context,
              text: '${state.addDeleteFavModel!.message}',
              color: Colors.red,
              icon: Icons.error_outline,
            );
          }
        }
      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('IShopIt'),
            actions: [
              if (cubit.index != 3)
                IconButton(
                    onPressed: () {
                      navPush(context, SearchScreen());
                    },
                    icon: Icon(Icons.search)),
              if (cubit.index == 3)
                defaultTexButton(
                  function: () {
                    CacheHelper.sharedPreferences!.remove('token').then(
                        (value) =>
                            navPushAndFinish(context, ShopLoginScreen()));
                  },
                  text: 'logout',
                ),
              IconButton(
                onPressed: () {
                  cubit.changeLang();
                },
                icon: Icon(Icons.language),
              ),
              IconButton(
                onPressed: () {
                  cubit.changeDarkLight();
                },
                icon: Icon(Icons.dark_mode),
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
