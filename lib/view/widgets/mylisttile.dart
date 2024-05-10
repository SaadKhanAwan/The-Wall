import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  final IconData? icon;
  final String? data;
  final VoidCallback ontab;
  const MyListTile({super.key, this.icon, this.data, required this.ontab});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: ontab,
      leading: Icon(
        icon,
        color: Colors.white,
        size: 30,
      ),
      title: Text(
        data.toString(),
        style: const TextStyle(
            letterSpacing: 4.5,
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
