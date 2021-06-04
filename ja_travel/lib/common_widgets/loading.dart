import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
