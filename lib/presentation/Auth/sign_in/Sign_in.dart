import 'package:flutter/material.dart';
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
              child: ListView(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Email Address",
                        hintText: "example@company.com",
                        focusColor: gold1,
                        suffix:
                            Icon(isEmailCorrect ? Icons.check : Icons.close),
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: brown1)),
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  TextFormField(
                    obscureText: isObscure,
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
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Home(),
                            )),
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
