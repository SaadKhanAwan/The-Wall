import 'package:flutter/material.dart';
import 'package:the_wall/utils/routes/route_name.dart';
import 'package:the_wall/view/widgets/mylisttile.dart';

import '../../viewmodel/services/auth/auth_services.dart';

class Mydrawer extends StatelessWidget {
  const Mydrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey.shade900,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const DrawerHeader(
                    child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 140,
                )),
                MyListTile(
                  icon: Icons.home,
                  data: "HOME",
                  ontab: () {
                    Navigator.pop(context);
                  },
                ),
                MyListTile(
                  icon: Icons.person,
                  data: "PROFILE",
                  ontab: () {
                    Navigator.pushNamed(context, RouteNames.profileScreen);
                  },
                )
              ],
            ),
            MyListTile(
              icon: Icons.logout,
              data: "LOGOUT",
              ontab: () async {
                await AuthServices.signOut(context: context).then((value) {
                  Navigator.pushReplacementNamed(
                      context, RouteNames.loginScreen);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
