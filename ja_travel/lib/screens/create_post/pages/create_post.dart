import 'package:flutter/material.dart';
import 'package:ja_travel/common_widgets/custom_form.dart';
import 'package:ja_travel/common_widgets/custom_image_base.dart';
import 'package:ja_travel/common_widgets/custom_textformfield.dart';
import 'package:ja_travel/common_widgets/loading.dart';
import 'package:ja_travel/models/place.dart';
import 'package:ja_travel/models/post.dart';
import 'package:ja_travel/provider/post_provider.dart';
import 'package:ja_travel/provider/user_provider.dart';
import 'package:provider/provider.dart';

class CreatePost extends StatefulWidget {
  CreatePost({Key? key, required this.data}) : super(key: key);

  final Object data;
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  /*Instanciacion de controladores */
  final TextEditingController descripcion = TextEditingController();
  final TextEditingController destino = TextEditingController();
  /*Future donde se almacenara la imagen si se cambia */
  Future<String?>? image;
  /*Place pasado por argumento */
  Place? place;

  @override
  void dispose() {
    descripcion.dispose();
    destino.dispose();
    super.dispose();
  }

  void validateAndSubmit() async {
    if (place != null || image != null) {
      showGeneralDialog(
        context: context,
        pageBuilder: (context, animation, secondaryAnimation) => Loading(
          onCall: () async {
            String? imagePostString = (await image);
            await context.read<PostProvider>().createOrSetPost(
                post: PostModel(
                    destino: destino.text,
                    descripcion: descripcion.text,
                    comments: {},
                    imagen: imagePostString == null
                        ? place!.imagen
                        : imagePostString,
                    imagenPerfil: context.read<UserProvider>().user!.image,
                    username: context.read<UserProvider>().user!.username,
                    uid: context.read<UserProvider>().user!.uid!,
                    likes: {},
                    id: context.read<PostProvider>().posts!.isEmpty
                        ? 0.toString()
                        : (int.parse(context
                                    .read<PostProvider>()
                                    .posts![context
                                            .read<PostProvider>()
                                            .posts!
                                            .length -
                                        1]
                                    .id) +
                                1)
                            .toString()));
            Navigator.pushNamedAndRemoveUntil(
                context, '/home', (route) => false);
          },
        ),
      );
    }
  }

  @override
  void initState() {
    place = widget.data as Place;
    destino.text = place != null
        ? "${place!.nombre}, ${place!.provincia} (${place!.pais})"
        : "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Crear Post",
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomImageBase(
              defaultImage: place!.imagen,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2,
              imageString: (value) => image = value,
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
              onPressedButton: (validate) {
                if (validate) validateAndSubmit();
              },
            ),
          ],
        ),
      ),
    );
  }
}
