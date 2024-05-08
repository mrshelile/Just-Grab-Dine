import 'dart:async';
import 'dart:io';
import 'package:justgrab_dine/application/Auth/Auth.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';

class MealController {
  final storage = FirebaseStorage.instance;
  Future processOrder({required oderId}) async {
    return await AuthUser()
        .firestore
        .collection("orders")
        .doc(oderId)
        .update({"status":"processed"});
  }

  Future uploadMeal(
      {required File image,
      required String title,
      required String price,
      required String description}) async {
    var imageName = basename(image.path);
    var storageRef = storage.ref().child(imageName);
    var uploadTask = storageRef.putFile(image);
    await uploadTask;
    var res = await AuthUser()
        .firestore
        .collection("restaurants")
        .where('user_id', isEqualTo: AuthUser().auth.currentUser!.uid)
        .get();
    AuthUser().firestore.collection("meals").add({
      "image": imageName,
      "name": title,
      "price": double.parse(price),
      "description": description,
      "restaurant_id": res.docs.first.reference
    });
  }
}
