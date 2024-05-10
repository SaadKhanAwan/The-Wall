import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:the_wall/utils/spacing/sizebox.dart';
import 'package:the_wall/utils/spacing/space.dart';
import 'package:the_wall/view/widgets/dailogues.dart';
import 'package:the_wall/view/widgets/textbox.dart';
import 'package:the_wall/viewmodel/services/auth/auth_services.dart';

import '../../../model/users.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.grey.shade900,
        centerTitle: true,
        title: const Text(
          "Profile",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: Pixels.width(context, 0.05)),
          child: StreamBuilder(
            stream: AuthServices.fetchUser(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Users data = snapshot.data!;
                String bio = data.bio.toString();
                String username = data.username.toString();

                return ListView(
                  children: [
                    const VerticalSizeBox(
                      height: .08,
                    ),
                    const Icon(
                      Icons.person,
                      size: 70,
                    ),
                    Text(
                      data.email.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    const Text("My details",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    TextBox(
                      username: "username",
                      bio: username,
                      ontab: () {
                        Dailogues.showUpdateBox(
                            context: context,
                            controller: usernameController,
                            value: username,
                            hintText: "username",
                            update: () async {
                              await AuthServices.updateUser(
                                  context, "username", usernameController.text);
                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                              log("working");
                            });
                      },
                    ),
                    TextBox(
                      username: "bio",
                      bio: bio,
                      ontab: () {
                        Dailogues.showUpdateBox(
                            context: context,
                            controller: bioController,
                            value: bio,
                            hintText: "bio",
                            update: () async {
                              await AuthServices.updateUser(
                                  context, "bio", bioController.text);
                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                              log("working");
                            });
                      },
                    ),
                  ],
                );
              } else {
                return const Center(child: Text("No Data Found"));
              }
            },
          )),
    );
  }
}
