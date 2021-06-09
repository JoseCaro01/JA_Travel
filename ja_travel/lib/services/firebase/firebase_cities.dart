import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ja_travel/models/place.dart';

class FirebaseCitiesApi {
  /*Singleton para API Ciudades */
  FirebaseCitiesApi._privateConstructor();
  static final FirebaseCitiesApi _instance =
      FirebaseCitiesApi._privateConstructor();
  static FirebaseCitiesApi get instance => _instance;

  /*Metodo para obtener lista de Ciudades */
  Future<List<Place>> getCities() async {
    List<Place> list = [];
    QuerySnapshot query =
        await FirebaseFirestore.instance.collection('cities').get();
    query.docs.forEach((element) {
      list.add(Place.fromMap(element.data()));
    });
    return list;
  }
}
