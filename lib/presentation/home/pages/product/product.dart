import 'dart:async';
// import 'dart:io';
// import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:justgrab_dine/application/Auth/Auth.dart';
import 'package:justgrab_dine/data/sign_up/remote/DTOs/product.dart';
import 'package:justgrab_dine/presentation/home/pages/product/pages/createPage.dart';
// import 'package:justgrab_dine/presentation/home/pages/product/pages/food_page.dart';
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
  StreamSubscription<QuerySnapshot>? meals;
  @override
  void initState() {
    super.initState();
    meals=AuthUser().firestore.collection("meals").snapshots().listen((event) {
      setState(() {
        
      });
    });
  }

  @override
  void dispose() {
    meals?.cancel();
    super.dispose();
  }

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

  final keys = [];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).copyWith().size;

    return Stack(
      children: [
        Container(
            padding: EdgeInsets.only(
              left: size.width * 0.03,
              right: size.width * 0.03,
            ),
            width: size.width * 1,
            child: StreamBuilder(
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text('Error fetching restaurant data');
                }
                if (!snapshot.hasData) {
                  return const SizedBox();
                }

                return GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 16 / 23,
                      crossAxisSpacing: 16,
                      crossAxisCount: 2,
                      mainAxisSpacing: 16),
                  children: [
                    for (var element in snapshot.data)
                      StreamBuilder(
                        stream: (element['restaurant_id'] as DocumentReference)
                            .snapshots(),
                        builder: (context, snapshot1) {
                          if (snapshot1.hasError) {
                            return const Text('Error fetching restaurant data');
                          }
                          if (!snapshot1.hasData ||
                              snapshot1.data!.data() == null) {
                            return const SizedBox();
                          }
                          Map<dynamic, dynamic> data1 =
                              snapshot1.data!.data() as Map<dynamic, dynamic>;
                          return Container(
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
                                      stream: getImageDownloadUrl(
                                              img: element['image'])
                                          .asStream(),
                                      builder: (context, imageSnap) {
                                        if (imageSnap.hasError) {
                                          return const SizedBox();
                                        }
                                        if (!imageSnap.hasData)
                                          return const SizedBox();
                                        // // print(imageSnap.data);
                                        food.name = element['name'];
                                        food.restaurant_name =
                                            data1['full_name'];
                                        food.restaurant_email_address =
                                            data1['email'];
                                        food.restaurant_location =
                                            data1['location'];
                                        food.restaurant_phone_number =
                                            data1['phone_number'];
                                        food.description =
                                            element['description'];
                                        food.imageUrl =
                                            imageSnap.data!.toString();
                                        // print(data);
                                        food.price = double.parse(
                                            element['price'].toString());
                                        // print(element);
                                        // food.productId = element.id;
                                        return Container(
                                          width: size.width,
                                          height: size.height * 0.17,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10)),
                                              image: DecorationImage(
                                                  image: NetworkImage(imageSnap
                                                      .data!
                                                      .toString()),
                                                  fit: BoxFit.cover)),
                                        );
                                      }),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        element['name'],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )),
                                  Container(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        data1['full_name'],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 12),
                                      )),
                                  Container(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        data1['email'],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 12),
                                      )),
                                  Container(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        data1['phone_number'].toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 12),
                                      )),
                                  Container(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.location_on,
                                            color: gold1,
                                          ),
                                          Text(
                                            data1['location'],
                                            style: const TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 12),
                                          ),
                                        ],
                                      )),
                                ],
                              ));
                        },
                      )
                  ],
                );
              },
              stream: mealsGet().asStream(),
            )),
        Positioned(
            left: size.width * 0.8,
            top: size.height * 0.6,
            child: CircleAvatar(
              radius: 30,
              backgroundColor: brown1,
              child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateAd(),
                        ));
                  },
                  icon: Icon(
                    Icons.create,
                    color: gold1,
                  )),
            ))
      ],
    );
  }

  Future mealsGet() async {
    var res = await AuthUser().firestore.collection("meals").get();
    List stream = [];
    // print(res.docs);
    for (var element in res.docs) {
      var data = element.data() as Map;
      // print(element);
      final res1 = await (data['restaurant_id'] as DocumentReference).get();
      final data1 = res1.data() as Map;

      if (data1['email'] == AuthUser().auth.currentUser!.email) {
        stream.add(element.data());
      }
    }
    // print(stream[0].);
    return stream;
  }
}
