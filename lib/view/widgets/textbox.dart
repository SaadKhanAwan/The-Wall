import 'package:flutter/material.dart';
import 'package:the_wall/utils/spacing/space.dart';

class TextBox extends StatelessWidget {
  final String? username;
  final String? bio;
  final VoidCallback? ontab;
  const TextBox({super.key, this.username, this.bio, this.ontab});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Pixels.height(context, .15),
      margin: EdgeInsets.symmetric(vertical: Pixels.height(context, 0.01)),
      padding: EdgeInsets.symmetric(
          horizontal: Pixels.width(context, 0.04),
          vertical: Pixels.height(context, 0.01)),
      decoration: BoxDecoration(
          color: const Color(0xffFFFFFF),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey.shade300)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                username.toString(),
                style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 18),
              ),
              InkWell(
                onTap: ontab,
                child: const Icon(
                  Icons.settings,
                  color: Colors.grey,
                ),
              )
            ],
          ),
          Text(
            bio.toString(),
            style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
