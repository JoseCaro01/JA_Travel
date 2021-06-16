import 'package:flutter/material.dart';
import 'package:ja_travel/common_widgets/custom_form.dart';
import 'package:ja_travel/common_widgets/custom_image_base.dart';
import 'package:ja_travel/common_widgets/custom_textformfield.dart';
import 'package:ja_travel/common_widgets/loading.dart';
import 'package:ja_travel/models/post.dart';
import 'package:ja_travel/provider/post_provider.dart';
import 'package:ja_travel/provider/user_provider.dart';
import 'package:provider/provider.dart';

class EditPost extends StatefulWidget {
  EditPost({Key? key, required this.data}) : super(key: key);

  final Object data;
  @override
  _EditPostState createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  final TextEditingController destino = TextEditingController();
  final TextEditingController descripcion = TextEditingController();
  PostModel? post;

  @override
  void initState() {
    post = widget.data as PostModel;
    destino.text = post!.destino;
    descripcion.text = post!.descripcion;
    super.initState();
  }

  @override
  void dispose() {
    destino.dispose();
    descripcion.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Editar post",
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              child: CustomImageBase(
                defaultImage: post!.imagen,
                fit: BoxFit.cover,
              ),
            ),
            CustomForm(
              children: [
                CustomTextFormField(
                  controller: destino,
                  label: "Destino",
                  validator: (value) => value!.isEmpty
                      ? "Debes introducir un destino valido"
                      : null,
                ),
                CustomTextFormField(
                  label: "Descripcion",
                  maxLines: 3,
                  validator: (value) => value!.isEmpty
                      ? "Debes introducir una descripcion valida"
                      : null,
                  controller: descripcion,
                ),
              ],
              titleButton: "Crear post",
              iconButton: Icons.post_add,
              onPressedButton: (validate) async {
                if (validate) {
                  post!.destino = destino.text;
                  post!.descripcion = descripcion.text;
                  post!.imagenPerfil = context.read<UserProvider>().user!.image;
                  await showGeneralDialog(
                    context: context,
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        Loading(
                      onCall: () async {
                        await context
                            .read<PostProvider>()
                            .createOrSetPost(post: post!)
                            .then((value) => Navigator.popUntil(context,
                                (route) => route.settings.name == '/home'));
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
