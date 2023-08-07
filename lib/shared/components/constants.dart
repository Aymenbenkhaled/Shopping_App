// http://146.59.159.198:4515/web/image?model=res.partner&field=avatar_128&id=38&unique=20230411053120

// http://146.59.159.198:4515/web/image?model=res.partner&id=38&field=avatar_128&unique=11042023073120

import 'package:ishopit/modules/login/shop_login_screen.dart';
import 'package:ishopit/shared/components/components.dart';
import 'package:ishopit/shared/network/local/cache_helper.dart';

String token = '';

String lang = '';

//bool? DarkLight ;

void SingOut(context) {
  CacheHelper.sharedPreferences!.remove('token').then(
          (value) =>
          navPushAndFinish(context, ShopLoginScreen()));
}