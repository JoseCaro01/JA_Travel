import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ja_travel/provider/post_provider.dart';
import 'package:ja_travel/provider/user_provider.dart';
import 'package:provider/provider.dart';

class PostActionRow extends StatelessWidget {
  /*Custom widget encargado de mostrar las posibles acciones a hacer en un post */
  const PostActionRow(
      {Key? key,
      required this.descriptionTextStyle,
      required this.postIndex,
      required this.showAllText,
      this.commentsAction})
      : super(key: key);

  /*Estilo de la descripciom */
  final TextStyle descriptionTextStyle;
  /*Index del post en la lista de post */
  final int postIndex;
  /*Controlador de mostrar todo el texto */
  final bool showAllText;
  /*Acciones de los comentarios (Default: Navegar y mostrar comentarios)*/
  final VoidCallback? commentsAction;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                    icon: Icon(context.watch<PostProvider>().isLikeIt(
                            post:
                                context.read<PostProvider>().posts![postIndex])
                        ? FontAwesomeIcons.solidHeart
                        : FontAwesomeIcons.heart),
                    color: context.watch<PostProvider>().isLikeIt(
                            post:
                                context.read<PostProvider>().posts![postIndex])
                        ? Colors.red
                        : Colors.black,
                    onPressed: () => context.read<PostProvider>().toogleLike(
                        post: context.read<PostProvider>().posts![postIndex])),
                IconButton(
                  icon: Icon(FontAwesomeIcons.comment),
                  onPressed: () => commentsAction == null
                      ? Navigator.pushNamed(context, '/detail_post',
                          arguments: [postIndex, true])
                      : commentsAction!(),
                ),
              ],
            ),
            IconButton(
              icon: Icon(context.watch<UserProvider>().isSave(
                      post: context.read<PostProvider>().posts![postIndex])
                  ? FontAwesomeIcons.solidStar
                  : FontAwesomeIcons.star),
              color: context.watch<UserProvider>().isSave(
                      post: context.read<PostProvider>().posts![postIndex])
                  ? Colors.yellow
                  : Colors.black,
              onPressed: () => context.read<UserProvider>().toogleFavourite(
                  post: context.read<PostProvider>().posts![postIndex]),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "${context.watch<PostProvider>().posts![postIndex].likes.length} Me gusta/s",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding:
              const EdgeInsets.only(left: 16, right: 16, bottom: 20, top: 10),
          child: Text(
            context
                .read<PostProvider>()
                .posts![postIndex]
                .descripcion
                .substring(
                    0,
                    context
                                .read<PostProvider>()
                                .posts![postIndex]
                                .descripcion
                                .indexOf("\n") ==
                            -1
                        ? context
                            .read<PostProvider>()
                            .posts![postIndex]
                            .descripcion
                            .length
                        : context
                            .read<PostProvider>()
                            .posts![postIndex]
                            .descripcion
                            .indexOf("\n")),
            textAlign: TextAlign.justify,
            overflow: !showAllText ? TextOverflow.ellipsis : null,
            style: descriptionTextStyle,
          ),
        ),
      ],
    );
  }
}
