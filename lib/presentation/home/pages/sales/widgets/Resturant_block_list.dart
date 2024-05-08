import 'package:flutter/material.dart';
import 'package:justgrab_dine/theme/colors.dart';

class ResturantBlockList extends StatefulWidget {
  const ResturantBlockList({super.key});

  @override
  State<ResturantBlockList> createState() => _ResturantBlockListState();
}

class _ResturantBlockListState extends State<ResturantBlockList> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).copyWith().size;
    return ListView.separated(
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 10);
        },
        scrollDirection: Axis.vertical,
        itemCount: 13,
        itemBuilder: (context, index) => Container(
              decoration: BoxDecoration(boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(255, 216, 221, 219),
                  offset: Offset(
                    5,
                    5.0,
                  ),
                  blurRadius: 15.0,
                  spreadRadius: 1.0,
                ),
              ], borderRadius: BorderRadius.circular(10), color: Colors.white),
              child: ListTile(
                trailing: IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.add,
                      color: brown1,
                    )),
                leading: Image.asset(
                  "assets/drink1.png",
                  height: size.height * 0.05,
                ),
                title: const Text("Thabo nape"),
                subtitle: const Text(
                  "email@email.com",
                  style: TextStyle(fontWeight: FontWeight.w300),
                ),
              ),
            ));
  }
}
