import 'package:flutter/material.dart';
import 'package:the_wall/utils/spacing/space.dart';
import 'package:the_wall/view/widgets/textfield.dart';

class Dailogues {
  // showing dailogue
  static void getSnacBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.blue,
    ));
  }

  // for progress Indecator
  static getProgrssindecator(
    BuildContext context,
  ) {
    return showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 4,
          ),
        );
      },
    );
  }

  static showUpdateBox({
    context,
    required TextEditingController controller,
    value,
    hintText,
    update,
  }) {
    controller.text = value.toString();
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              color: Colors.grey.shade800,
              padding: const EdgeInsets.all(20),
              height: Pixels.height(context, .26),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Text(
                    "Edit $hintText",
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 18),
                  )),
                  MyTexxtField(
                      controller: controller,
                      hintText: hintText,
                      obscureText: false),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "cancel",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 15),
                          )),
                      TextButton(
                          onPressed: update,
                          child: const Text(
                            "Update",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 15),
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static showCommentBox(
      {context,
      required TextEditingController controller,
      hintText,
      required onpress}) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              color: Colors.grey.shade800,
              padding: const EdgeInsets.all(20),
              height: Pixels.height(context, .26),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                      child: Text(
                    "Add Comment",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 18),
                  )),
                  MyTexxtField(
                      controller: controller,
                      hintText: hintText,
                      obscureText: false),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            controller.clear();
                          },
                          child: const Text(
                            "cancel",
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                          )),
                      TextButton(
                          onPressed: onpress,
                          child: const Text(
                            "Comment",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static showDeleteBox({required context, required onpress}) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              color: Colors.grey.shade800,
              padding: const EdgeInsets.all(20),
              height: Pixels.height(context, .26),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                      child: Text(
                    "Delete Post",
                    maxLines: null,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 18),
                  )),
                  const Text(
                    "Are you sure you want to delete your post.",
                    maxLines: null,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 18),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "cancel",
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                          )),
                      TextButton(
                          onPressed: onpress,
                          child: const Text(
                            "Delete",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
