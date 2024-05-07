import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData {
  Stream getData() {
    final _mealStream = FirebaseFirestore.instance.collection('meals');


    return _mealStream.snapshots();
  }
}
