import 'package:flutter/material.dart';
import 'package:justgrab_dine/application/Auth/Auth.dart';
import 'package:justgrab_dine/presentation/Auth/sign_in/Sign_in.dart';
import '../../../theme/colors.dart';
import '../../home/Home.dart';
import 'widgets/Background1.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isEmailCorrect = false;
  bool isObscure = true;
  final formkey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phonenumberController = TextEditingController();
  final locationController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  String error = "";
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).copyWith().size;
    return Scaffold(
      body: Stack(
        children: [
          const Background1(),
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
                    controller: nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "field is required";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: "Restaurant Name",
                        hintText: "thabos food",
                        focusColor: gold1,
                        suffix: IconButton(
                            onPressed: () {
                              nameController.clear();
                            },
                            icon: const Icon(Icons.close)),
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: brown1)),
                  ),
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
                            icon: const Icon(Icons.close)),
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: brown1)),
                  ),
                  TextFormField(
                    controller: locationController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "field is required";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: "Location",
                        hintText: "e.g Ha Masau",
                        focusColor: gold1,
                        suffix: IconButton(
                            onPressed: () {
                              locationController.clear();
                            },
                            icon: const Icon(Icons.close)),
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: brown1)),
                  ),
                  TextFormField(
                    controller: phonenumberController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "field is required";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: "Phone Number",
                        hintText: "(+266)..",
                        focusColor: gold1,
                        suffix: IconButton(
                            onPressed: () {
                              phonenumberController.clear();
                            },
                            icon: const Icon(Icons.close)),
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: brown1)),
                  ),
                  TextFormField(
                    controller: passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "field is required";
                      }
                      return null;
                    },
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
                  TextFormField(
                    controller: confirmPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "field is required";
                      }
                      return null;
                    },
                    obscureText: isObscure,
                    decoration: InputDecoration(
                        labelText: "Confirm Password",
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
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignIn(),
                            ));
                      },
                      child: const Text(
                        "Already Sign in? Login",
                        style: TextStyle(
                          color: Colors.cyan,
                        ),
                      )),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: size.width * 0.1, right: size.width * 0.1),
                    child: TextButton(
                        style: TextButton.styleFrom(backgroundColor: brown1),
                        onPressed: () async {
                          if (formkey.currentState!.validate()) {
                            if (confirmPasswordController.text
                                .trim()
                                .endsWith(passwordController.text.trim())) {
                              setState(() {
                                error = '';
                              });
                              var res = await AuthUser().signUp(
                                  emailAddress: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                  restaurantName: nameController.text.trim(),
                                  location: locationController.text.trim(),
                                  phone: phonenumberController.text.trim());
                              if (res.statusCode == 201) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const SignIn(),
                                    ));
                              } else {
                                setState(() {
                                  error = res.body;
                                });
                              }
                            } else {
                              setState(() {
                                error = "Password do not match";
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
                          "Create",
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
