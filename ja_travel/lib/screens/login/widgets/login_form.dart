import 'package:flutter/material.dart';
import 'package:ja_travel/common_widgets/custom_form.dart';
import 'package:ja_travel/common_widgets/custom_textformfield.dart';
import 'package:ja_travel/common_widgets/loading.dart';
import 'package:ja_travel/provider/cities_provider.dart';
import 'package:ja_travel/provider/login_provider.dart';
import 'package:ja_travel/provider/post_provider.dart';
import 'package:ja_travel/provider/user_provider.dart';
import 'package:ja_travel/screens/login/widgets/forget_password.dart';
import 'package:ja_travel/utils/validator.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  /*Instanciacion de los controladores de los TextFormField */
  final TextEditingController email =
      TextEditingController(text: "jose@gmail.com");

  final TextEditingController password =
      TextEditingController(text: "mascara12");

  @override
  void dispose() {
    /*Destruccion de los controladores de los TextFormField*/
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomForm(
      iconButton: Icons.login,
      onPressedButton: (validate) async {
        if (validate) {
          await context
              .read<UserProvider>()
              .loginUser(email: email.text, password: password.text);
          showGeneralDialog(
            context: context,
            pageBuilder: (context, animation, secondaryAnimation) => Loading(
              onCall: () async {
                await context.read<UserProvider>().getUserData();
                await context.read<PostProvider>().getPosts();
                await context.read<CityProvider>().getCities();

                Navigator.pushNamedAndRemoveUntil(
                    context, '/home', (route) => false);
              },
            ),
          ).then((value) {
            if (value != null) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.red,
                  content: Text(value.toString())));
            } else {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/home', (route) => false);
            }
          });
        }
      },
      titleButton: 'Login',
      children: [
        CustomTextFormField(
            label: "Email",
            validator: (value) => value!.isValidEmail()
                ? null
                : "Debes introducir un email válido",
            controller: email,
            prefixIcon: Icon(Icons.email)),
        CustomTextFormField(
          label: "Contraseña",
          validator: (value) => value!.isValidPassword()
              ? null
              : "Debes introducir una contraseña válida",
          controller: password,
          prefixIcon: Icon(Icons.lock),
          suffixIcon: IconButton(
            icon: Icon(Icons.remove_red_eye),
            onPressed: () => context.read<LoginProvider>().toogleShowPassword(),
          ),
          obscureText: context.watch<LoginProvider>().showPassword,
        ),
        TextButton(
            onPressed: () => showForgetDialog(context),
            child: Text("¿Has olvidado tu contraseña?")),
      ],
    );
  }

  Future<dynamic> showForgetDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return ForgetPassword();
      },
    );
  }
}
