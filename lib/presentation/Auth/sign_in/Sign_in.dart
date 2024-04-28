import 'package:flutter/material.dart';
import 'package:justgrab_dine/application/Auth/Auth.dart';
import '../../../theme/colors.dart';
import '../../home/Home.dart';
import 'widgets/Background.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool isEmailCorrect = false;
  bool isObscure = false;
  final formkey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  String error = "";
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).copyWith().size;
    return Scaffold(
      body: Stack(
        children: [
          Background(),
          Container(
            padding: EdgeInsets.only(
                top: size.height * 0.4,
                left: size.width * 0.1,
                right: size.width * 0.1),
            child: Form(
              key: formkey,
              child: ListView(
                children: [
                  TextFormField(
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "field is required";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: "Email Address",
                        hintText: "example@company.com",
                        focusColor: gold1,
                        suffix: IconButton(
                            onPressed: () {
                              emailController.clear();
                            },
                            icon: Icon(Icons.close)),
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: brown1)),
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  TextFormField(
                    controller: passwordController,
                    obscureText: isObscure,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "field is required";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: "Password",
                        hintText: "*********",
                        focusColor: gold1,
                        suffix: IconButton(
                            onPressed: () => setState(() {
                                  isObscure = !isObscure;
                                }),
                            icon: Icon(
                              isObscure
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: brown1,
                            )),
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: brown1)),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Container(
                      // padding: EdgeInsets.only(left: size.width * 0.1),
                      child: GestureDetector(
                          onTap: () {}, child: Text("Forgot password"))),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: size.width * 0.1, right: size.width * 0.1),
                    child: TextButton(
                        style: TextButton.styleFrom(backgroundColor: brown1),
                        onPressed: () async {
                          setState(() {
                            error = "";
                          });
                          if (formkey.currentState!.validate()) {
                            var res = await AuthUser().userLogin(
                                emailAddress: emailController.text.trim(),
                                password: passwordController.text.trim());
                            if (res.statusCode == 200) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Home(),
                                  ));
                            } else {
                              setState(() {
                                error = res.body;
                              });
                            }
                          }
                          if (error.isNotEmpty) {
                            final snackdemo = SnackBar(
                              content: Text(error),
                              backgroundColor: brown1,
                              elevation: 10,
                              behavior: SnackBarBehavior.floating,
                              margin: const EdgeInsets.all(5),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackdemo);
                          }
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: white1, fontWeight: FontWeight.bold),
                        )),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
