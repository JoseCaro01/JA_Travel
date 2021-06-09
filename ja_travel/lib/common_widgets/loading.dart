import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  /*Widget encargado de mostrar pantalla de cargando ademas de realizar las peticiones asincronas */
  const Loading({Key? key, required this.onCall}) : super(key: key);

  final VoidCallback onCall;

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    widget.onCall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        color: Colors.transparent,
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
