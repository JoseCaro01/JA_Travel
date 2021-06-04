import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ja_travel/models/place.dart';

class FirebaseCitiesApi {
  FirebaseCitiesApi._privateConstructor();
  static final FirebaseCitiesApi _instance =
      FirebaseCitiesApi._privateConstructor();
  static FirebaseCitiesApi get instance => _instance;

  getCities() async {
    List<PlaceModel> list = [];
    QuerySnapshot query =
        await FirebaseFirestore.instance.collection('cities').get();
    query.docs.forEach((element) {
      list.add(PlaceModel.fromMap(element.data()));
    });
    return list;
  }
}
