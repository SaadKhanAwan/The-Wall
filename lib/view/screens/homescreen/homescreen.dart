import 'package:flutter/material.dart';
import 'package:the_wall/model/post_model.dart';
import 'package:the_wall/utils/spacing/space.dart';
import 'package:the_wall/view/widgets/mydrawer.dart';
import 'package:the_wall/view/widgets/postcard.dart';
import 'package:the_wall/view/widgets/textfield.dart';
import 'package:the_wall/viewmodel/services/post/post_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController postcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.grey.shade900,
        centerTitle: true,
        title: const Text(
          "The Wall",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Pixels.width(context, 0.04)),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                  stream: PostServices.fetchPost(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            Post post = snapshot.data![index];
                            return PostCard(
                                email: post.email!,
                                post: post.post!,
                                postId: post.id,
                                like: post.likes!.toList());
                          });
                    } else {
                      return const Text("no post found");
                    }
                  }),
            ),
            Row(
              children: [
                Expanded(
                  child: MyTexxtField(
                      controller: postcontroller,
                      hintText: "enter your post",
                      obscureText: false),
                ),
                GestureDetector(
                    onTap: () async {
                      await PostServices.createPost(post: postcontroller.text);
                      postcontroller.clear();
                    },
                    child: const Icon(Icons.send)),
              ],
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
      drawerScrimColor: Colors.white,
      drawer: const Mydrawer(),
    );
  }
}
