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
    return context.read<CityProvider>().places.isEmpty
        ? Center(
            child: CircularProgressIndicator(
            backgroundColor: Colors.white,
          ))
        : CitiesWidget();
  }
}
