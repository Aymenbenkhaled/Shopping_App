import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ishopit/layout/shop_layout.dart';
import 'package:ishopit/modules/login/cubit/cubit.dart';
import 'package:ishopit/modules/login/cubit/state.dart';
import 'package:ishopit/modules/register/register_screen.dart';
import 'package:ishopit/shared/components/components.dart';
import 'package:ishopit/shared/network/local/cache_helper.dart';
import 'package:ishopit/shared/style/colors.dart';

class ShopLoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.loginModel.status == true) {
              CacheHelper.saveData(
                  key: 'token', value: state.loginModel.data!.token).then((
                  value) {
                if (value) navPushAndFinish(context, ShopLayout());
              });
            } else {
              customFlutterToast(
                context: context,
                text: '${state.loginModel.message}',
                color: Colors.red,
                icon: Icons.error_outline,
              );
            }
          }
        },
        builder: (context, state) {
          var cubit = ShopLoginCubit.get(context);
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
                          'LOGIN',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Login To Browse Our Hot Offers',
                          style: TextStyle(fontSize: 18, color: Colors.grey
                            //fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          label: 'Email Address',
                          prefIcon: Icons.email_outlined,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter You Email Adress';
                            }
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          label: 'Password',
                          prefIcon: Icons.password,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter You Email Adress';
                            }
                          },
                          obscureText: cubit.obscure,
                          suffIcon: cubit.icon,
                          suffpressd: () {
                            cubit.ChangeVisibility();
                          },
                          onSubmit: (value) {
                            if (formKey.currentState!.validate()) {
                              cubit.LoginUser(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context) =>
                              defaultBotton(
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    cubit.LoginUser(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                  }
                                },
                                text: 'login',
                                width: double.infinity,
                                radius: 0,
                                isUpperCase: true,
                                color: Colors.white,
                              ),
                          fallback: (context) =>
                              Center(
                                child: CircularProgressIndicator(),
                              ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t Have An Account ? '),
                            defaultTexButton(
                                function: () {
                                  navPush(context, RegisterScreen());
                                },
                                text: 'REGISTER'),
                          ],
                        ),
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
