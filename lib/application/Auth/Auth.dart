import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthUser {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  Future<Response> userLogin(
      {required String emailAddress, required String password}) async {
    try {
      final user = await auth.signInWithEmailAndPassword(
          email: emailAddress, password: password);
      // var de = await firestore.collection("users");
      final res = await firestore
          .collection("restaurants")
          .where("user_id", isEqualTo: user.user!.uid)
          .get();
      if (res.docs.isEmpty) {
        throw FirebaseAuthException(code: "not-restaurant");
      }
      return const Response(statusCode: 200, body: "Authenticated");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return const Response(statusCode: 204, body: "User not found");
      } else if (e.code == 'wrong-password') {
        return const Response(statusCode: 401, body: "Wrong password");
      }

      return const Response(statusCode: 500, body: "Wrong credientials");
    }
  }

  Future<Response> signUp(
      {required String emailAddress,
      required String password,
      required String restaurantName,
      required String location,
      // required String
      required String phone}) async {
    try {
      final userCredential = await auth.createUserWithEmailAndPassword(
          email: emailAddress, password: password);

      await firestore.collection("restaurants").add({
        "full_name": restaurantName,
        "phone_number": phone,
        "email": emailAddress,
        "location": location,
        "allowed": false,
        "user_id": userCredential.user!.uid
      });
      return const Response(statusCode: 201, body: "user created");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return const Response(statusCode: 409, body: "weak password");
      } else if (e.code == 'email-already-in-use') {
        return const Response(statusCode: 409, body: "email already in use");
      }
      return const Response(statusCode: 500, body: "Unhandled error");
    } catch (e) {
      return const Response(statusCode: 500, body: "Unhandled error");
    }
  }
}
