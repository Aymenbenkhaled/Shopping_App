import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ishopit/layout/cubit/cubit.dart';
import 'package:ishopit/models/search_model.dart';
import 'package:ishopit/modules/search/cubit/cubit.dart';
import 'package:ishopit/modules/search/cubit/state.dart';
import 'package:ishopit/shared/components/components.dart';
import 'package:ishopit/shared/style/colors.dart';

class SearchScreen extends StatelessWidget {

  var searchController = TextEditingController();

  GlobalKey formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SearchCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: defaultFormField(
                    controller: searchController,
                    type: TextInputType.text,
                    label: 'Search',
                    prefIcon: Icons.search,
                    validate: (value) {
                      if(value != null){
                        return 'No Data To Search';
                      }
                    },
                    onSubmit: (value){
                      print(value);
                      cubit.SearchData(value);
                    },
                  ),
                ),
                //SizedBox(height: 5,),
                if (state is SearchLoadingState)
                  LinearProgressIndicator(),
                if( state is SearchSuccessState)
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsetsDirectional.symmetric(horizontal: 3),
                      padding: EdgeInsetsDirectional.all(1),
                      color: Colors.grey,
                      child: GridView.count(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        childAspectRatio: 1 / 1.5,
                        mainAxisSpacing: 1,
                        crossAxisSpacing: 1,
                        crossAxisCount: 2,
                        children: List.generate(cubit.searchModel!.data!.data.length,
                                (index) => buildGridViewItem(index, cubit.searchModel!.data!.data,cubit,context)),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildGridViewItem(int index, List<ProductModel> model,SearchCubit cubit,context) {
    return Container(
      padding: EdgeInsetsDirectional.all(2),
      color: Colors.white,
      child: Column(
        children: [
          Image(
            image: NetworkImage('${model[index].image}'),
            width: double.infinity,
            height: 200,
          ),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            //mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '${model[index].name}',
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
                    '${model[index].price.round()}',
                    style: TextStyle(
                      fontSize: 14,
                      color: defaultColor,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                      onPressed: () {
                        //print(model.data!.products[index].id);
                        ShopCubit.get(context).AddOrDeleteFavorites(model[index].id);
                      },
                      icon: (ShopCubit.get(context).favoorites[model[index].id] == false) ? Icon(
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
