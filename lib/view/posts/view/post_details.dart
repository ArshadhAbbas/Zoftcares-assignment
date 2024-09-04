import 'package:flutter/material.dart';
import 'package:zoftcares/models/posts_model.dart';
import 'package:zoftcares/repository/login_repo/login_repo.dart';

class PostDetails extends StatelessWidget {
  const PostDetails({super.key, required this.post});
  final Datum post;
  static const String routePath = "/post_details";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(post.title ?? ""),
        actions: [
          IconButton(
            tooltip: "Logout",
            onPressed: () {
              LoginRepo().logOut(context);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("ID: ${post.id}"),
              const SizedBox(height: 20),
              Text("Body: ${post.body}"),
              const SizedBox(height: 20),
              Text("Image Url: ${post.image}"),
            ],
          ),
        ),
      ),
    );
  }
}
