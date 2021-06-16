import 'package:flutter/material.dart';
import 'package:ja_travel/models/place.dart';
import 'package:ja_travel/provider/user_provider.dart';
import 'package:ja_travel/screens/description_place/pages/description_place_widget.dart';
import 'package:ja_travel/screens/map_place/pages/map_place_widget.dart';
import 'package:ja_travel/screens/weather_place/pages/weather_place_widget.dart';
import 'package:ja_travel/utils/color_config.dart';
import 'package:provider/provider.dart';

class DetailViewCities extends StatefulWidget {
  const DetailViewCities({Key? key, required this.data}) : super(key: key);

  final Object data;

  @override
  _DetailViewCitiesState createState() => _DetailViewCitiesState();
}

class _DetailViewCitiesState extends State<DetailViewCities> {
  /*Place pasado mediante argumento una vez se navega desde CitiesScreen */
  Place? place;

  @override
  void initState() {
    place = widget.data as Place;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        floatingActionButton: context.read<UserProvider>().user != null
            ? FloatingActionButton.extended(
                onPressed: () => Navigator.pushNamed(context, '/create_post',
                    arguments: place),
                label: Text("Crear post"),
                icon: Icon(Icons.add),
              )
            : FloatingActionButton.extended(
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                    context, '/login', (route) => false),
                label: Text("Iniciar sesion"),
                icon: Icon(Icons.add),
              ),
        appBar: AppBar(
          title: Text(
            "Detalle de ${place!.nombre}",
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
          bottom: TabBar(
            indicatorColor: ColorConfig.tabsIndicatorAndBottomNavigationColor,
            labelColor: ColorConfig.tabsIndicatorAndBottomNavigationColor,
            tabs: [
              Tab(
                icon: Icon(
                  Icons.description,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.cloud,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.place,
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            DescriptionPlaceWidget(place: place!),
            WeatherPlaceWidget(place: place!),
            MapPlaceWidget(place: place!),
          ],
        ),
      ),
    );
  }
}
