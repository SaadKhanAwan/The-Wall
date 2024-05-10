import 'package:flutter/material.dart';
import 'package:the_wall/utils/spacing/space.dart';

class MyButton extends StatelessWidget {
  final String buttonName;
  final Function() myfunction;
  const MyButton(
      {super.key, required this.buttonName, required this.myfunction});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: myfunction,
      child: Container(
        width: double.infinity,
        height: Pixels.height(context, .08),
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(15)),
        child: Center(
          child: Text(
            buttonName,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
