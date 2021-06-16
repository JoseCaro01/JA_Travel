import 'package:flutter/material.dart';
import 'package:ja_travel/common_widgets/custom_form.dart';
import 'package:ja_travel/common_widgets/custom_textformfield.dart';
import 'package:ja_travel/common_widgets/loading.dart';
import 'package:ja_travel/provider/user_provider.dart';
import 'package:ja_travel/utils/validator.dart';
import 'package:provider/provider.dart';

class EditPasswordProfile extends StatefulWidget {
  const EditPasswordProfile({Key? key}) : super(key: key);

  @override
  _EditPasswordProfileState createState() => _EditPasswordProfileState();
}

class _EditPasswordProfileState extends State<EditPasswordProfile> {
  final TextEditingController newPassword = TextEditingController();
  final TextEditingController newPasswordConfirmation = TextEditingController();
  final TextEditingController ancientPassword = TextEditingController();

  @override
  void dispose() {
    newPassword.dispose();
    newPasswordConfirmation.dispose();
    ancientPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cambiar contraseña",
            style: Theme.of(context).appBarTheme.titleTextStyle),
      ),
      body: CustomForm(
        widthText: 150,
        fixedSizeButton: Size(280, 40),
        iconButton: Icons.change_circle_outlined,
        titleButton: "Cambiar la contraseña",
        onPressedButton: (validate) {
          if (validate)
            showGeneralDialog(
              context: context,
              pageBuilder: (context, animation, secondaryAnimation) => Loading(
                onCall: () async => await context
                    .read<UserProvider>()
                    .changePassword(
                        newPassword: newPassword.text,
                        password: ancientPassword.text)
                    .then((value) => Navigator.popUntil(
                        context, (route) => route.settings.name == '/home')),
              ),
            );
        },
        children: [
          CustomTextFormField(
            label: 'Antigua contraseña',
            validator: (value) => value!.isValidPassword()
                ? null
                : "No has introducido una contraseña valida",
            controller: ancientPassword,
            obscureText: true,
          ),
          CustomTextFormField(
              label: "Nueva contraseña",
              obscureText: true,
              validator: (value) => value!.isValidPassword()
                  ? null
                  : "No has introducido una contraseña valida",
              controller: newPassword),
          CustomTextFormField(
              obscureText: true,
              textInputAction: TextInputAction.done,
              label: "Nueva contraseña confirmación",
              validator: (value) => value! == newPassword.text
                  ? null
                  : "No has introducido una contraseña valida",
              controller: newPasswordConfirmation)
        ],
      ),
    );
  }
}
