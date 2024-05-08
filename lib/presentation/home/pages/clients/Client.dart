import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:justgrab_dine/application/Auth/Auth.dart';
import 'package:justgrab_dine/application/Product/MealController.dart';
import 'package:justgrab_dine/presentation/util/util1.dart';

// import '../../../../theme/colors.dart';

class orders extends StatefulWidget {
  const orders({super.key});

  @override
  State<orders> createState() => _ordersState();
}

class _ordersState extends State<orders> {
  StreamSubscription<QuerySnapshot>? orders;
  @override
  void initState() {
    super.initState();
    orders =
        AuthUser().firestore.collection("orders").snapshots().listen((event) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    orders?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).copyWith().size;
    return StreamBuilder(
        stream: AuthUser()
            .firestore
            .collection("orders")
            .where("status", isEqualTo: "waiting")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError || !snapshot.hasData) {
            return SizedBox();
          }
          // final data = snapshot.data!.docs as Map;
          // print(data);
          // print(snapshot.data!.docs.first.data()['meals'].first);
          return Container(
            padding: EdgeInsets.only(
              left: size.width * 0.03,
              right: size.width * 0.03,
            ),
            width: size.width * 1,
            child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 10);
                },
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) => Container(
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
                      child: ListTile(
                        trailing: IconButton(
                            onPressed: () async {
                              // snapshot.data!.docs[index]
                              await MealController().processOrder(
                                  oderId: snapshot.data!.docs[index].id);
                            },
                            icon: const Icon(
                              Icons.wifi_protected_setup,
                              color: Colors.cyan,
                            )),
                        leading: StreamBuilder(
                            stream: (snapshot.data!.docs.first
                                    .data()['meals']
                                    .first['meal'] as DocumentReference)
                                .snapshots(),
                            builder: (context, mealSnap) {
                              if (mealSnap.hasError || !mealSnap.hasData) {
                                return const SizedBox();
                              }
                              final mealdata = mealSnap.data!.data() as Map;

                              return StreamBuilder(
                                  stream: getImageDownloadUrl(
                                          img: mealdata['image'])
                                      .asStream(),
                                  builder: (context, imageSnap) {
                                    if (!imageSnap.hasData ||
                                        imageSnap.hasError) {
                                      return const SizedBox();
                                    }
                                    final imagedata = imageSnap.data;
                                    // print(imagedata);
                                    return Image.network(
                                      imagedata.toString(),
                                      height: size.height * 0.05,
                                    );
                                  });
                            }),
                        title: StreamBuilder(
                            stream: AuthUser()
                                .firestore
                                .collection("users")
                                .where("user_id",
                                    isEqualTo: snapshot.data!.docs[index]
                                        ['client'])
                                .snapshots(),
                            builder: (context, userSnap) {
                              if (userSnap.hasError || !userSnap.hasData) {
                                return const SizedBox();
                              }
                              return Text(
                                  "${userSnap.data!.docs.first.data()['full_name']} M${snapshot.data!.docs[index]['total_price']}");
                            }),
                        subtitle: Text(
                          snapshot.data!.docs[index].id,
                          style: const TextStyle(fontWeight: FontWeight.w300),
                        ),
                      ),
                    )),
          );
        });
  }
}
