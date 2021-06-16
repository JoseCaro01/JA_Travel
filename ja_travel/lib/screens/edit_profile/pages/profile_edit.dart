import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ja_travel/common_widgets/custom_textformfield.dart';
import 'package:ja_travel/common_widgets/loading.dart';
import 'package:ja_travel/common_widgets/profile_photo_background.dart';
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
  final TextEditingController description = TextEditingController();

  Future<String?>? photo;
  Future<String?>? banner;

  @override
  void initState() {
    username.text = context.read<UserProvider>().user!.username;
    name.text = context.read<UserProvider>().user!.name;
    address.text = context.read<UserProvider>().user!.address;
    phone.text = context.read<UserProvider>().user!.phone;
    description.text = context.read<UserProvider>().user!.description;
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
            color: Theme.of(context).appBarTheme.titleTextStyle!.color,
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
                color: Theme.of(context).appBarTheme.titleTextStyle!.color,
              ))
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            ProfilePhotoBackground(
              bannerProfileImage: context.read<UserProvider>().user!.banner,
              photoProfileImage: context.read<UserProvider>().user!.image,
              photoProfile: (value) => photo = value,
              bannerProfile: (value) => banner = value,
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
                      CustomTextFormField(
                        label: "Descripción",
                        validator: (value) => value!.isEmpty
                            ? "Debes introducir una descripción válida"
                            : null,
                        textInputAction: TextInputAction.newline,
                        maxLines: 3,
                        controller: description,
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
    );
  }

  void validateAndSubmit(bool validate) {
    if (validate) {
      showGeneralDialog(
        context: context,
        pageBuilder: (context, animation, secondaryAnimation) => Loading(
          onCall: () async {
            String? photoAwait = await photo;
            String? bannerAwait = await banner;
            context.read<UserProvider>().user!.username = username.text;
            context.read<UserProvider>().user!.phone = phone.text;
            context.read<UserProvider>().user!.name = name.text;
            context.read<UserProvider>().user!.address = address.text;
            context.read<UserProvider>().user!.description = description.text;
            context.read<UserProvider>().user!.image = photoAwait != null
                ? photoAwait
                : context.read<UserProvider>().user!.image;
            context.read<UserProvider>().user!.banner = bannerAwait != null
                ? bannerAwait
                : context.read<UserProvider>().user!.banner;

            await context
                .read<UserProvider>()
                .updateUserData(user: context.read<UserProvider>().user!);

            await context.read<PostProvider>().setPostsImageProfileImage(
                imageProfile: photoAwait == null
                    ? context.read<UserProvider>().user!.image
                    : photoAwait,
                username: context.read<UserProvider>().user!.username,
                uid: context.read<UserProvider>().user!.uid!);

            Navigator.pushNamedAndRemoveUntil(
                context, '/home', (route) => false);
          },
        ),
      );
    }
  }
}
