import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  /*Este custom widget se encarga de la funcionalidad de un buscador en la Appbar mediante el uso de un controller*/
  const CustomAppBar(
      {Key? key,
      required this.controller,
      required this.title,
      required this.titleSearch})
      : super(key: key);

  /*Controlador del TextField */
  final TextEditingController controller;
  /*Titulo de la appbar en modo normal */
  final String title;
  /*Tiutlo de la appBar en modo buscador */
  final String titleSearch;

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  /*Booleano encargado de gestionar si es buscador o no*/
  bool searchOrSee = false;

  @override
  Widget build(BuildContext context) {
    return searchOrSee
        ? AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () => setState(() {
                searchOrSee = false;
              }),
            ),
            title: TextField(
              controller: widget.controller,
              decoration: InputDecoration(
                  hintText: widget.titleSearch, border: InputBorder.none),
            ),
            actions: [
                IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: Colors.black,
                    ),
                    onPressed: () => widget.controller.text = "")
              ] //BORRAR QUERY,)],
            )
        : AppBar(
            automaticallyImplyLeading: false,
            title: Text(widget.title,
                style: Theme.of(context).appBarTheme.titleTextStyle),
            actions: [
              IconButton(
                  onPressed: () => setState(() {
                        searchOrSee = true;
                      }),
                  icon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ))
            ],
          );
  }
}
