import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ja_travel/common_widgets/custom_image_base.dart';
import 'package:ja_travel/common_widgets/custom_textformfield.dart';
import 'package:ja_travel/common_widgets/loading.dart';
import 'package:ja_travel/default_image.dart';
import 'package:ja_travel/provider/post_provider.dart';
import 'package:ja_travel/provider/user_provider.dart';
import 'package:ja_travel/utils/validator.dart';
import 'package:provider/provider.dart';

class ProfileEdit extends StatefulWidget {
  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  final _key = GlobalKey<FormState>();

  final TextEditingController username = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController phone = TextEditingController();

  Future<String?>? image;

  @override
  void initState() {
    username.text = context.read<UserProvider>().user!.username;
    name.text = context.read<UserProvider>().user!.name;
    address.text = context.read<UserProvider>().user!.address;
    phone.text = context.read<UserProvider>().user!.phone;
    super.initState();
  }

  @override
  void dispose() {
    username.dispose();
    name.dispose();
    address.dispose();
    phone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.clear,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Editar perfil",
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        actions: [
          IconButton(
              onPressed: () async {
                _key.currentState!.save();
                validateAndSubmit(_key.currentState!.validate());
              },
              icon: Icon(
                Icons.save,
                color: Colors.black,
              ))
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                    shape: BoxShape.circle),
                child: ClipOval(
                  child: CustomImageBase(
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                    defaultImage: context.read<UserProvider>().user!.image,
                    imageString: (value) => image = value,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Form(
                    key: _key,
                    child: Column(
                      children: [
                        CustomTextFormField(
                          controller: username,
                          label: "Nombre de usuario",
                          validator: (value) => value!.isEmpty
                              ? "Debes introducir un nombre de usuario válido"
                              : null,
                          prefixIcon: Icon(Icons.person),
                        ),
                        CustomTextFormField(
                          label: "Nombre",
                          validator: (value) => value!.isEmpty
                              ? "Debes introducir un nombre válido"
                              : null,
                          controller: name,
                          prefixIcon: Icon(FontAwesomeIcons.addressCard),
                        ),
                        CustomTextFormField(
                          controller: address,
                          label: "Direccion",
                          prefixIcon: Icon(Icons.email),
                          validator: (value) => value!.isEmpty
                              ? "Debes introducir una direccion válida"
                              : null,
                        ),
                        CustomTextFormField(
                          controller: phone,
                          label: "Teléfono",
                          prefixIcon: Icon(Icons.phone),
                          validator: (value) => !value!.isNumber()
                              ? "Debes introducir un numero de telefono válido"
                              : null,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  void validateAndSubmit(bool validate) {
    if (validate) {
      showGeneralDialog(
        context: context,
        pageBuilder: (context, animation, secondaryAnimation) => Loading(
          onCall: () async {
            String? imageBase = (await image);
            context.read<UserProvider>().user!.username = username.text;
            context.read<UserProvider>().user!.phone = phone.text;
            context.read<UserProvider>().user!.name = name.text;
            context.read<UserProvider>().user!.address = address.text;
            context.read<UserProvider>().user!.image = imageBase != null
                ? imageBase
                : context.read<UserProvider>().user!.image;
            await context
                .read<UserProvider>()
                .updateUserData(user: context.read<UserProvider>().user!);

            await context.read<PostProvider>().setPostsImageProfileImage(
                imageProfile: imageBase == null ? DEFAULT_IMAGE : imageBase,
                username: context.read<UserProvider>().user!.username,
                uid: context.read<UserProvider>().user!.uid!);

            Navigator.popUntil(
                (context), (route) => route.settings.name == '/home');
          },
        ),
      );
    }
  }
}
