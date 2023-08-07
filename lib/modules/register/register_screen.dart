import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ishopit/layout/shop_layout.dart';
import 'package:ishopit/modules/register/cubit/cubit.dart';
import 'package:ishopit/modules/register/cubit/state.dart';
import 'package:ishopit/shared/components/components.dart';
import 'package:ishopit/shared/components/constants.dart';
import 'package:ishopit/shared/network/local/cache_helper.dart';

class RegisterScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.registerModel.status == true) {
              CacheHelper.saveData(
                  key: 'token', value: state.registerModel.data!.token).then((
                  value) {
                token = state.registerModel.data!.token!;
                if (value) navPushAndFinish(context, ShopLayout());
              });
            } else {
              CustomFlutterToast(
                context: context,
                text: '${state.registerModel.message}',
                color: Colors.red,
                icon: Icons.error_outline,
              );
            }
          }
        },
        builder: (context, state) {
          var cubit = ShopRegisterCubit.get(context);
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Register To Browse Our Hot Offers',
                          style: TextStyle(fontSize: 18, color: Colors.grey
                              //fontWeight: FontWeight.bold,
                              ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          label: 'Name',
                          prefIcon: Icons.person,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Name';
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
                          prefIcon: Icons.email_outlined,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Email Adress';
                            }
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          label: 'Password',
                          prefIcon: Icons.password,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Password';
                            }
                          },
                          obscureText: cubit.obscure,
                          suffIcon: cubit.icon,
                          suffpressd: () {
                            cubit.ChangeVisibility();
                          },
                          onSubmit: (value) {
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          label: 'Phone',
                          prefIcon: Icons.phone,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Phone';
                            }
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState,
                          builder: (context) => defaultBotton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                cubit.RegisterUser(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                            text: 'register',
                            width: double.infinity,
                            radius: 0,
                            isUpperCase: true,
                            color: Colors.white,
                          ),
                          fallback: (context) => Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Text('Don\'t Have An Account ? '),
                        //     defaultTexButton(
                        //         function: () {
                        //           navPush(context, RegisterScreen());
                        //         },
                        //         text: 'REGISTER'),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
