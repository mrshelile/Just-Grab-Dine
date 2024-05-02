import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:justgrab_dine/application/Auth/Auth.dart';
import 'package:justgrab_dine/data/sign_up/remote/DTOs/product.dart';
import 'package:justgrab_dine/presentation/home/pages/product/pages/food_page.dart';
import '../../../../theme/colors.dart';

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  ProductModel food = ProductModel(
      restaurant_location: '',
      description: '',
      imageUrl: "",
      restaurant_name: '',
      restaurant_email_address: '',
      price: 0.0,
      name: '',
      restaurant_phone_number: '',
      productId: '');

  // Stream _myMealsStream=(){};
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

  final Stream _mealStream = () {
    final user = AuthUser().auth.currentUser;
    print("dds");
    if (user != null) {
      Stream steam;
      // var temp = AuthUser()
      //     .firestore
      //     .collection("restaurants")
      //     .where("user_id", isEqualTo: user.uid)
      //     .get()
      //     .then((value) => print(value));
      print("temp");
      return Stream.empty();
    } else {
      return Stream.empty();
    }
  }();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).copyWith().size;
         // var temp = AuthUser()
      //     .firestore
      //     .collection("restaurants")
      //     .where("user_id", isEqualTo: user.uid)
      //     .get()
      //     .then((value) => print(value));
    return Container(
        padding: EdgeInsets.only(
          left: size.width * 0.03,
          right: size.width * 0.03,
        ),
        width: size.width * 1,
        child: StreamBuilder(
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error fetching restaurant data');
            }
            if (!snapshot.hasData) {
              return SizedBox();
            }

            // return SizedBox();
            return GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 16 / 23,
                  crossAxisSpacing: 16,
                  crossAxisCount: 2,
                  mainAxisSpacing: 16),
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;

                return FutureBuilder(
                  future: (data['restaurant_id']
                          as DocumentReference<Map<String, dynamic>>)
                      .get(),
                  builder: (context, snapshot1) {
                    // return SizedBox();
                    if (snapshot1.hasError) {
                      return Text('Error fetching restaurant data');
                    }
                    if (!snapshot1.hasData || snapshot1.data!.data() == null) {
                      return SizedBox();
                    }
                    // print(snapshot1.data!.data());
                    // return SizedBox();
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FoodDetail(
                                  item: food,
                                ),
                              ));
                        },
                        child: Container(
                          height: 200,
                          decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromARGB(255, 216, 221, 219),
                                  offset: Offset(
                                    5,
                                    5.0,
                                  ),
                                  blurRadius: 15.0,
                                  spreadRadius: 1.0,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.start,
                            children: [
                              StreamBuilder<Object>(
                                  stream:
                                      getImageDownloadUrl(img: data['image'])
                                          .asStream(),
                                  builder: (context, imageSnap) {
                                    if (imageSnap.hasError) {
                                      return SizedBox();
                                    }
                                    if (!imageSnap.hasData) return SizedBox();
                                    // print(imageSnap.data);
                                    food.name = data['title'];
                                    food.restaurant_name =
                                        snapshot1.data!.data()!['name'];
                                    food.restaurant_email_address =
                                        snapshot1.data!.data()!['email'];
                                    food.restaurant_location =
                                        snapshot1.data!.data()!['location'];
                                    food.restaurant_phone_number =
                                        snapshot1.data!.data()!['phone_number'];
                                    food.description = data['description'];
                                    food.imageUrl = imageSnap.data!.toString();
                                    food.price =
                                        double.parse(data['price'].toString());
                                    food.productId = document.id;
                                    return Container(
                                      width: size.width,
                                      height: size.height * 0.17,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  imageSnap.data!.toString()),
                                              fit: BoxFit.cover)),
                                    );
                                  }),
                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    data['title'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  )),
                              Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    snapshot1.data!.data()!['name'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12),
                                  )),
                              Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    snapshot1.data!.data()!['email'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12),
                                  )),
                              Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    snapshot1.data!.data()!['phone_number'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12),
                                  )),
                              Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        color: gold1,
                                      ),
                                      Text(
                                        snapshot1.data!.data()!['location']
                                            ['district'],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 12),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        ));
                  },
                );
              }).toList(),
            );
          },
          stream: _mealStream,
        ));
  }
}
