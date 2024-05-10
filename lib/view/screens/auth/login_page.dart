import 'package:flutter/material.dart';
import 'package:the_wall/utils/routes/route_name.dart';
import 'package:the_wall/utils/spacing/sizebox.dart';
import 'package:the_wall/utils/spacing/space.dart';
import 'package:the_wall/view/widgets/button.dart';
import 'package:the_wall/view/widgets/dailogues.dart';
import 'package:the_wall/view/widgets/textfield.dart';
import 'package:the_wall/viewmodel/services/auth/auth_services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
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
                    "welcome back your are been missed!",
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
                    height: .04,
                  ),
                  MyButton(
                      buttonName: "Log in",
                      myfunction: () async {
                        if (globalKey.currentState!.validate()) {
                          Dailogues.getProgrssindecator(
                              context); // Show loading indicator

                          try {
                            final value = await AuthServices.signIn(
                                email: emailController.text.trim(),
                                password: passwordController.text,
                                context: context);
                            if (!context.mounted) return;

                            Navigator.of(context).pop();

                            if (value != null) {
                              Navigator.of(context)
                                  .pushReplacementNamed(RouteNames.homeScreen);
                              Dailogues.getSnacBar(
                                  context, "Login Successfully");
                            } else {
                              if (context.mounted) {
                                Dailogues.getSnacBar(context,
                                    "Login Failed: Invalid credentials or user does not exist.");
                              }
                            }
                          } catch (e) {
                            if (context.mounted) {
                              Navigator.of(context)
                                  .pop(); // Ensure loading indicator is dismissed in case of an error
                              Dailogues.getSnacBar(context,
                                  "An error occurred: ${e.toString()}");
                            }
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
                        "Not a member?",
                        style: TextStyle(color: Colors.grey),
                      ),
                      HorizantalSizeBox(width: Pixels.width(context, .00006)),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, RouteNames.registerScreen);
                        },
                        child: const Text(
                          "Register",
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
