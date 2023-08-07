import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ishopit/layout/cubit/cubit.dart';
import 'package:ishopit/layout/cubit/state.dart';
import 'package:ishopit/models/categories_model.dart';
import 'package:ishopit/shared/components/components.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return ListView.separated(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) =>
                buildCategoryItem(cubit.categoriesModel!.data!.data![index]),
            separatorBuilder: (context, index) =>  buildSeparator(),
            itemCount: cubit.categoriesModel!.data!.data!.length,
        );
      },
    );
  }

  Widget buildCategoryItem(CategoriesDataModel model) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(
          image: NetworkImage('${model.image}'),
          width: 110,
          height: 110,
          fit: BoxFit.cover,
        ),
        SizedBox(width: 10,),
        Expanded(
          child: Text('${model.name}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_forward_ios),
        )
      ],
    ),
  );
}
