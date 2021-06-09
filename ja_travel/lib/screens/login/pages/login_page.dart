import 'package:flutter/material.dart';
import 'package:ja_travel/common_widgets/custom_elevatedbutton.dart';
import 'package:ja_travel/screens/login/widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                      child: Text(
                    "JA TRAVEL",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  )),
                ),
                LoginForm(),
                CustomElevatedButton(
                  title: "Registrarse",
                  iconData: Icons.person_add,
                  onPressed: () => Navigator.pushNamed(context, '/register'),
                ),
                CustomElevatedButton(
                  title: "Anonimo",
                  iconData: Icons.person,
                  onPressed: () {
                    Navigator.pushNamed(context, '/anonymus');
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
