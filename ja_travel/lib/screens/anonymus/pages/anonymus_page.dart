import 'package:flutter/material.dart';
import 'package:ja_travel/provider/cities_provider.dart';
import 'package:ja_travel/screens/cities/pages/cities_widget.dart';
import 'package:provider/provider.dart';

class AnonymusPage extends StatefulWidget {
  const AnonymusPage({Key? key}) : super(key: key);

  @override
  _AnonymusPageState createState() => _AnonymusPageState();
}

class _AnonymusPageState extends State<AnonymusPage> {
  @override
  void initState() {
    context.read<CityProvider>().getCities();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return context.watch<CityProvider>().places.isEmpty
        ? Container(
            color: Colors.grey[50],
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.white,
            )),
          )
        : CitiesWidget();
  }
}
