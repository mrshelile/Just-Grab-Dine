import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData {
  Stream getData() {
    final _mealStream = FirebaseFirestore.instance.collection('meals');

    final _restaurantStream =
        FirebaseFirestore.instance.collection('restaurants').doc();

    return _mealStream.snapshots();
  }
}
