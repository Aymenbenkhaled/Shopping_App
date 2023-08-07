import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ishopit/layout/cubit/cubit.dart';
import 'package:ishopit/layout/cubit/state.dart';
import 'package:ishopit/shared/components/components.dart';
import 'package:ishopit/shared/components/constants.dart';

class SettingsScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        nameController.text = cubit.userData!.data!.name!;
        emailController.text = cubit.userData!.data!.email!;
        phoneController.text = cubit.userData!.data!.phone!;
        return ConditionalBuilder(
          condition: cubit.userData != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is ShopUpdateUserDataLoadingState)
                LinearProgressIndicator(),
                SizedBox(height: 20,),
                defaultFormField(
                  controller: nameController,
                  type: TextInputType.name,
                  label: 'Name',
                  prefIcon: Icons.person,
                  validate: (value) {
                    if (value != null) {
                      return 'Name Must Not Be Empty';
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                defaultFormField(
                  controller: emailController,
                  type: TextInputType.emailAddress,
                  label: 'Email Address',
                  prefIcon: Icons.email,
                  validate: (value) {
                    if (value != null) {
                      return 'Email Address Must Not Be Empty';
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                defaultFormField(
                  controller: phoneController,
                  type: TextInputType.phone,
                  label: 'Phone',
                  prefIcon: Icons.phone,
                  validate: (value) {
                    if (value != null) {
                      return 'Phone Must Not Be Empty';
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                defaultBotton(
                  function: () => cubit.UpdateUserData(nameController.text,emailController.text,phoneController.text),
                  text: 'update',
                  width: double.infinity,
                  radius: 0,
                ),
              ],
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
