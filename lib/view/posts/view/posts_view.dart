import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zoftcares/constants/extensions.dart';
import 'package:zoftcares/controller/posts_provider.dart';
import 'package:zoftcares/controller/session_controller.dart';
import 'package:zoftcares/repository/login_repo/login_repo.dart';
import 'package:zoftcares/view/posts/view/post_details.dart';

class PostsView extends StatefulWidget {
  const PostsView({super.key});
  static const routePath = "posts_view";

  @override
  State<PostsView> createState() => _PostsViewState();
}

class _PostsViewState extends State<PostsView> {
  final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    scrollController.addListener(_onScroll);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PostsProvider>(context, listen: false).fetchPosts();
    });
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<PostsProvider>().fetchPosts();
    }
  }

  bool get _isBottom {
    if (!scrollController.hasClients) return false;
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.offset;
    return currentScroll >= (maxScroll * 0.99);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SessionController>(
      builder: (context, sessionController, child) {
        if (!sessionController.isSessionActive) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            context.showSnackbarExtension("Session Expired");
          });

          LoginRepo().logOut(context);
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text("Posts"),
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
          body: Consumer<PostsProvider>(
            builder: (context, postsProvider, child) {
              if (postsProvider.error != null) {
                return Center(child: Text(postsProvider.error.toString()));
              }
              if (postsProvider.posts.isEmpty && !postsProvider.isLoadingMore) {
                return const Center(child: CircularProgressIndicator());
              } else if (postsProvider.posts.isEmpty) {
                return const Center(child: Text("No Data"));
              }

              return ListView.separated(
                controller: scrollController,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemCount: postsProvider.posts.length +
                    (postsProvider.isLoadingMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == postsProvider.posts.length) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final post = postsProvider.posts[index];
                  return ListTile(
                    onTap: () => Navigator.pushNamed(
                        context, PostDetails.routePath,
                        arguments: post),
                    leading: CircleAvatar(
                      radius: 30,
                      child: Text("Id:${post.id}"),
                    ),
                    title: Text(
                      post.title ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      post.body ?? "",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
