import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  /*Widget encargado de mostrar pantalla de cargando ademas de realizar las peticiones asincronas */
  const Loading({Key? key, this.onCall, this.color}) : super(key: key);

  /*Tipo funcion para realizar los async calls */
  final VoidCallback? onCall;
  /*Cambiar color de fondo */
  final Color? color;

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    if (widget.onCall != null) widget.onCall!();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        color: widget.color == null ? Colors.transparent : widget.color,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
            child: CircularProgressIndicator(
          backgroundColor: Colors.white,
        )),
      ),
    );
  }
}
