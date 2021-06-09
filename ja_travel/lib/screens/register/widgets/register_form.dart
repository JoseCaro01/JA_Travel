import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ja_travel/common_widgets/custom_form.dart';
import 'package:ja_travel/common_widgets/custom_textformfield.dart';
import 'package:ja_travel/common_widgets/custom_tile.dart';
import 'package:ja_travel/common_widgets/loading.dart';
import 'package:ja_travel/models/user.dart';
import 'package:ja_travel/provider/cities_provider.dart';
import 'package:ja_travel/provider/post_provider.dart';
import 'package:ja_travel/provider/user_provider.dart';
import 'package:ja_travel/utils/validator.dart';
import 'package:provider/provider.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  /*Instanciacion de los controladores de los TextFormField */
  final TextEditingController email = TextEditingController(),
      username = TextEditingController(),
      name = TextEditingController(),
      address = TextEditingController(),
      phone = TextEditingController(),
      password = TextEditingController(),
      passwordRepit = TextEditingController();

  @override
  void dispose() {
    /*Destruccion de los controladores de los TextFormField*/
    username.dispose();
    name.dispose();
    address.dispose();
    phone.dispose();
    password.dispose();
    passwordRepit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomForm(
        children: [
          CustomTextFormField(
              label: "Email",
              validator: (value) => value!.isValidEmail()
                  ? null
                  : "Debes introducir un email valido",
              controller: email,
              prefixIcon: Icon(Icons.email)),
          CustomTextFormField(
              label: "Username",
              validator: (value) => value!.isEmpty
                  ? "Debes de introducir un nombre de usuario válido"
                  : null,
              controller: username,
              prefixIcon: Icon(Icons.person)),
          CustomTextFormField(
              label: "Nombre completo",
              validator: (value) => value!.isEmpty
                  ? "Debes introducir un nombre completo válido"
                  : null,
              controller: name,
              prefixIcon: Icon(FontAwesomeIcons.addressCard)),
          CustomTextFormField(
              label: "Direccion",
              validator: (value) => value!.isEmpty
                  ? "Debes introducir una dirección válida"
                  : null,
              controller: address,
              prefixIcon: Icon(FontAwesomeIcons.addressBook)),
          CustomTextFormField(
              label: "Telefono",
              validator: (value) => value!.isNumber()
                  ? null
                  : "Debes de introducir un numero de telefono válido",
              controller: phone,
              prefixIcon: Icon(Icons.phone)),
          CustomTextFormField(
              obscureText: true,
              label: "Contraseña",
              validator: (value) => value!.isValidPassword()
                  ? null
                  : "Debes introducir una contraseña al menos con una mayúscula y 8 cararcteres",
              controller: password,
              prefixIcon: Icon(Icons.lock)),
          CustomTextFormField(
              obscureText: true,
              label: "Repite la contraseña",
              validator: (value) => value == password.text && value!.isNotEmpty
                  ? null
                  : "Debe introducir una contraseña igual a la anterior",
              controller: passwordRepit,
              prefixIcon: Icon(Icons.lock)),
          SizedBox(
            height: 15,
          )
        ],
        titleButton: "Registrarse",
        iconButton: Icons.person_add,
        onPressedButton: (validate) async {
          if (validate) {
            await context
                .read<UserProvider>()
                .registerUser(
                  email: email.text,
                  password: password.text,
                  user: UserModel(
                      favourites: {},
                      username: username.text,
                      name: name.text,
                      address: address.text,
                      phone: phone.text,
                      followers: 0,
                      followed: {},
                      image: ''),
                )
                .then((value) {
              if (value != null) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.red,
                    content: CustomTile(
                      textStyle: TextStyle(color: Colors.white),
                      icon: Icon(
                        Icons.error,
                        color: Colors.white,
                      ),
                      width: MediaQuery.of(context).size.width - 100,
                      label: value,
                    )));
              } else {
                showGeneralDialog(
                  context: context,
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      Loading(
                    onCall: () async {
                      await context.read<PostProvider>().getPosts();
                      await context.read<CityProvider>().getCities();
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                  ),
                );
              }
            });
          }
        });
  }
}
