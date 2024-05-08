  import 'package:firebase_storage/firebase_storage.dart';

Future<String> getImageDownloadUrl({required String img}) async {
    final storageRef = FirebaseStorage.instance.ref().child(img);

    try {
      final url = await storageRef.getDownloadURL();
      return url;
    } catch (error) {
      // Handle error getting download URL
      print(error);
      return "";
    }
  }