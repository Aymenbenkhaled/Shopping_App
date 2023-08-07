import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ishopit/layout/cubit/cubit.dart';
import 'package:ishopit/layout/cubit/state.dart';
import 'package:ishopit/models/categories_model.dart';
import 'package:ishopit/models/home_model.dart';
import 'package:ishopit/shared/components/components.dart';
import 'package:ishopit/shared/style/colors.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.homeModel != null && cubit.categoriesModel != null && cubit.favoritesModel != null,
          builder: (context) =>
              buildSliderItem(cubit.homeModel, cubit.categoriesModel,cubit),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget buildSliderItem(
      HomeModel? productModel, CategoriesModel? categoryModel, cubit) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: productModel!.data!.banners!
                .map((element) => Image(
                      image: NetworkImage('${element.image}'),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ))
                .toList(),
            options: CarouselOptions(
                height: 250,
                scrollDirection: Axis.horizontal,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(seconds: 3),
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                initialPage: 0,
                reverse: false,
                viewportFraction: 1),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CATEGORIES',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  height: 100,
                  //color: Colors.grey,
                  child: ListView.separated(
                      scrollDirection: axisDirectionToAxis(AxisDirection.right),
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) =>
                          buildCategoriesItem(categoryModel, index),
                      separatorBuilder: (context, index) => SizedBox(
                            width: 8,
                          ),
                      itemCount: categoryModel!.data!.data!.length),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'PRODUCTS',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsetsDirectional.all(1),
            color: Colors.grey,
            child: GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              childAspectRatio: 1 / 1.5,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              crossAxisCount: 2,
              children: List.generate(productModel.data!.products.length,
                  (index) => buildGridViewItem(index, productModel,cubit)),
            ),
          )
        ],
      ),
    );
  }

  Widget buildCategoriesItem(categoryModel, index) =>
      Stack(alignment: AlignmentDirectional.bottomCenter, children: [
        Image(
          image: NetworkImage(
            '${categoryModel.data!.data![index].image}',
          ),
          fit: BoxFit.cover,
          width: 100,
          height: 100,
        ),
        Container(
          width: 100,
          height: 20,
          decoration: BoxDecoration(
            color: Colors.black87,
          ),
          child: Center(
            child: Text(
              '${categoryModel.data!.data![index].name}',
              style: TextStyle(
                fontSize: 13,
                color: Colors.white,
              ),
            ),
          ),
        )
      ]);

  Widget buildGridViewItem(int index, HomeModel? model,ShopCubit cubit) {
    return Container(
      padding: EdgeInsetsDirectional.all(2),
      color: Colors.white,
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage('${model!.data!.products[index].image}'),
                width: double.infinity,
                height: 200,
              ),
              if (model.data!.products[index].discount != 0)
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
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            //mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '${model.data!.products[index].name}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 15, height: 1),
              ),
              //Spacer(),
              SizedBox(
                height: 3,
              ),
              Row(
                children: [
                  Text(
                    '${model.data!.products[index].price.round()}',
                    style: TextStyle(
                      fontSize: 14,
                      color: defaultColor,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  if (model.data!.products[index].discount != 0)
                    Text(
                      '${model.data!.products[index].old_price.round()}',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                          decorationColor: Colors.red),
                    ),
                  Spacer(),
                  IconButton(
                      onPressed: () {
                        print(model.data!.products[index].id);
                        cubit.AddOrDeleteFavorites(model.data!.products[index].id);
                      },
                      icon: (cubit.favoorites[model.data!.products[index].id] == false) ? Icon(
                        Icons.favorite_border,
                        size: 27,
                      ) : Icon(
                        Icons.favorite,
                        size: 27,
                        color: Colors.red,
                      )
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
