import 'package:flutter/material.dart';

import '../../../../theme/colors.dart';


class Client extends StatefulWidget {
  const Client({super.key});

  @override
  State<Client> createState() => _ClientState();
}

class _ClientState extends State<Client> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).copyWith().size;
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
          itemCount: 13,
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
                      onPressed: null, icon: Icon(Icons.block_sharp,color: reeed1,)),
                  leading: Image.asset(
                    "assets/imag1.png",
                    height: size.height * 0.05,
                  ),
                  title: const Text("Thabo nape"),
                  subtitle: const Text(
                    "email@email.com",
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                ),
              )),
    );
  }
}
