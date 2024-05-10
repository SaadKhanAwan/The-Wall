import 'package:flutter/material.dart';
import 'package:the_wall/utils/routes/route_name.dart';
import 'package:the_wall/utils/spacing/sizebox.dart';
import 'package:the_wall/utils/spacing/space.dart';
import 'package:the_wall/view/widgets/button.dart';
import 'package:the_wall/view/widgets/dailogues.dart';
import 'package:the_wall/view/widgets/textfield.dart';
import 'package:the_wall/viewmodel/services/auth/auth_services.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();
  final globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Form(
        key: globalKey,
        child: Center(
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: Pixels.width(context, .05)),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.lock,
                    size: 80,
                  ),
                  const VerticalSizeBox(
                    height: .08,
                  ),
                  const Text(
                    "Lets create a account for you",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  const VerticalSizeBox(
                    height: .04,
                  ),
                  MyTexxtField(
                    controller: emailController,
                    hintText: "enter your email",
                    obscureText: false,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'email is empty';
                      }
                      return null;
                    },
                  ),
                  const VerticalSizeBox(
                    height: .02,
                  ),
                  MyTexxtField(
                    controller: passwordController,
                    hintText: "enter your password",
                    obscureText: true,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'password is empty';
                      }
                      return null;
                    },
                  ),
                  const VerticalSizeBox(
                    height: .02,
                  ),
                  MyTexxtField(
                    controller: confirmpasswordController,
                    hintText: "Confirm your password",
                    obscureText: true,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'confirm password is empty';
                      } else if (passwordController.text !=
                          confirmpasswordController.text) {
                        return "password dont match ";
                      }
                      return null;
                    },
                  ),
                  const VerticalSizeBox(
                    height: .04,
                  ),
                  MyButton(
                      buttonName: "Sign up",
                      myfunction: () async {
                        if (globalKey.currentState!.validate()) {
                          Dailogues.getProgrssindecator(context);
                          try {
                            final newUser = await AuthServices.signUp(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                            if (newUser != null) {
                              Navigator.pushReplacementNamed(
                                  // ignore: use_build_context_synchronously
                                  context,
                                  RouteNames.homeScreen);
                              Dailogues.getSnacBar(
                                  // ignore: use_build_context_synchronously
                                  context,
                                  "Sign up successfully");
                            } else {
                              Dailogues.getSnacBar(
                                  // ignore: use_build_context_synchronously
                                  context,
                                  "Failed to sign up");
                            }
                          } catch (e) {
                            Dailogues.getSnacBar(
                                // ignore: use_build_context_synchronously
                                context,
                                "Failed to sign up: ${e.toString()}");
                          }
                        }
                      }),
                  const VerticalSizeBox(
                    height: .04,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already register?",
                        style: TextStyle(color: Colors.grey),
                      ),
                      HorizantalSizeBox(width: Pixels.width(context, .00006)),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RouteNames.loginScreen);
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
