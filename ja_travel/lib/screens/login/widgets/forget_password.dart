import 'package:flutter/material.dart';

import 'package:ja_travel/common_widgets/custom_textformfield.dart';
import 'package:ja_travel/provider/user_provider.dart';
import 'package:ja_travel/utils/validator.dart';
import 'package:provider/provider.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({
    Key? key,
  }) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  /*Instanciacion de los controladores de los TextFormField */
  final TextEditingController email = TextEditingController();
  final _key = GlobalKey<FormState>();

  @override
  void dispose() {
    /*Destruccion de los controladores de los TextFormField*/
    email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Restablecer contraseña"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(
                "Introduzca su correo electronico y le enviaremos un correo para recuperarlo"),
          ),
          Form(
            key: _key,
            child: CustomTextFormField(
                label: "Email",
                validator: (value) => value!.isValidEmail()
                    ? null
                    : "Debes introducir un email valido",
                controller: email),
          )
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("CANCELAR"),
        ),
        TextButton(
          onPressed: () {
            _key.currentState!.save();
            if (_key.currentState!.validate()) {
              context
                  .read<UserProvider>()
                  .recoverPassword(email: email.text)
                  .then((value) => Navigator.pop(context));
            }
          },
          child: Text("RESTABLECER"),
        )
      ],
    );
  }
}
