import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ishopit/layout/cubit/cubit.dart';
import 'package:ishopit/layout/cubit/state.dart';
import 'package:ishopit/models/favorites_model.dart';
import 'package:ishopit/shared/components/components.dart';
import 'package:ishopit/shared/style/colors.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          var cubit = ShopCubit.get(context);
          return ListView.separated(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) =>
                buildFavItem(cubit.favoritesModel!.data!.data![index].product,cubit),
            separatorBuilder: (context, index) =>  buildSeparator(),
            itemCount: cubit.favoritesModel!.data!.data!.length,
          );
        },
      );
  }

  Widget buildFavItem(FavProductDataModel? FavModel,cubit){
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        height: 110,
        width: double.infinity,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(
                      '${FavModel!.image}'),
                  width: 100,
                  height: 100,
                  fit: BoxFit.fill,
                ),
                if (FavModel.discount != 0)
                  Container(
                    width: 60,
                    height: 15,
                    color: Colors.red,
                    child: Center(
                      child: Text(
                        'DISCOUNT',
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ),
                  )
              ],
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${FavModel.name}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 20, height: 1),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        '${FavModel.price}',
                        style: TextStyle(
                          fontSize: 20,
                          color: defaultColor,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      if (FavModel.discount != 0)
                        Text(
                          '${FavModel.oldPrice}',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                              decorationColor: Colors.red),
                        ),
                      Spacer(),
                      IconButton(
                          onPressed: () {
                            cubit.AddOrDeleteFavorites(FavModel.id);
                          },
                          //icon: (cubit.favoorites[model.data!.products[index].id] == false) ? Icon(
                          icon: (cubit.favoorites[FavModel.id] == false)
                              ? Icon(
                            Icons.favorite_border,
                            size: 27,
                          )
                              : Icon(
                            Icons.favorite,
                            size: 27,
                            color: Colors.red,
                          ))
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
