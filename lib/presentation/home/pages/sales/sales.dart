import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:justgrab_dine/application/Auth/Auth.dart';
// import 'package:justgrab_dine/application/Product/MealController.dart';
import 'package:justgrab_dine/presentation/util/util1.dart';

import '../../../../theme/colors.dart';

class SalesList extends StatefulWidget {
  const SalesList({super.key});

  @override
  State<SalesList> createState() => _SalesListState();
}

class _SalesListState extends State<SalesList> {
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
            .where("status", isNotEqualTo: "waiting")
            .where("status")
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
                        trailing:
                            snapshot.data!.docs[index]['status'] != "delivered"
                                ? Icon(
                                    Icons.delivery_dining,
                                    color: brown1,
                                  )
                                : const Icon(Icons.call_received),
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
