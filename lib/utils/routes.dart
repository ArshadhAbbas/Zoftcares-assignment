import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zoftcares/controller/connectivity_provider.dart';
import 'package:zoftcares/models/posts_model.dart';
import 'package:zoftcares/view/login/view/login_view.dart';
import 'package:zoftcares/view/posts/view/post_details.dart';
import 'package:zoftcares/view/posts/view/posts_view.dart';

class Routes {
  static PageRoute<dynamic>? generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case LoginView.routePath:
        return goto(const LoginView());

      case PostsView.routePath:
        return goto(const PostsView());

      case PostDetails.routePath:
        {
          final args = routeSettings.arguments as Datum;
          return goto(PostDetails(post: args));
        }

      default:
        {
          return goto(const Scaffold(
            body: Center(
              child: Text("Invalid Route"),
            ),
          ));
        }
    }
  }

  static PageRoute<dynamic>? goto(Widget screen) {
    return MaterialPageRoute(
        builder: (context) => Consumer<ConnectivityProvider>(
            builder: (context, connectivityProvider, child) =>
                connectivityProvider.isOnline
                    ? screen
                    : Scaffold(
                        appBar: AppBar(),
                        body: const Center(
                          child: Text("No Network"),
                        ),
                      )));
  }
}
