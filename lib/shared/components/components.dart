
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ishopit/shared/style/colors.dart';

import '../cubit/cubit.dart';
import '../cubit/states.dart';
import '../network/local/cache_helper.dart';

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  required String label,
  double radius = 0,
  required IconData prefIcon,
  IconData? suffIcon,
  void Function(String)? onSubmit,
  void Function(String)? onChange,
  Function()? onTap,
  required String? Function(String?)? validate,
  bool obscureText = false,
  Function()? suffpressd,
  //required String text,
}) =>
    BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return TextFormField(
          controller: controller,
          keyboardType: type,
          onFieldSubmitted: onSubmit,
          onChanged: onChange,
          validator: validate,
          obscureText: obscureText,
          onTap: onTap,
          decoration: InputDecoration(
            prefixIcon: Icon(
              prefIcon,
            ),
            suffixIcon: IconButton(
              onPressed: suffpressd,
              icon: Icon(
                suffIcon,
              ),
            ),
            labelText: label,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
              gapPadding: 10,
            ),
          ),
        );
      },
    );

Widget defaultTexButton({
  required Function() function,
  required String text,

})=>TextButton(onPressed: function, child: Text(text.toUpperCase()));

Widget defaultBotton({
  double width = 200,
  double? height,
  double radius = 30,
  double textSize = 30,
  //Color background = Colors.lightBlueAccent,
  bool isUpperCase = true,
  required Function function,
  required String text,
  Color color = Colors.white,
}) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: defaultColor,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: MaterialButton(
        onPressed: () {
          function();
        },
        //(){print('${emailController.text} //// ${passwordController.text} ' );},
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            fontSize: textSize,
            color: color,
          ),
        ),
      ),
    );

void navPush(context, widget) {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ));
}

void navPushAndFinish(context, widget) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (Route<dynamic> route) => false,
  );
}

Widget buildSeparator() {
  return Padding(
    padding: const EdgeInsetsDirectional.only(start: 20),
    child: Container(
      width: double.infinity,
      height: 1,
      color: Colors.grey[500],
    ),
  );
}

class ImageBuilder extends StatelessWidget {
  const ImageBuilder({
    Key? key,
    required this.imagePath,
    this.imgWidth = 200,
    this.imgheight = 200,
  }) : super(key: key);

  final String imagePath;
  final double imgWidth;
  final double imgheight;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath,
      width: imgWidth,
      height: imgheight,
    );
  }
}
