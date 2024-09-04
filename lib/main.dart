import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoftcares/controller/connectivity_provider.dart';
import 'package:zoftcares/controller/login_controller.dart';
import 'package:zoftcares/controller/posts_provider.dart';
import 'package:zoftcares/controller/session_controller.dart';
import 'package:zoftcares/utils/routes.dart';
import 'package:zoftcares/view/login/view/login_view.dart';
import 'package:zoftcares/view/posts/view/posts_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? timeOut = prefs.getString("timeOut");
  late MyApp app;
  timeOut == null || DateTime.parse(timeOut).isBefore(DateTime.now())
      ? app = const MyApp()
      : app = const MyApp(initailRoute: PostsView.routePath);
  runApp(app);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.initailRoute = LoginView.routePath});
  final String initailRoute;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PostsProvider()),
        ChangeNotifierProvider(create: (context) => SessionController()),
        ChangeNotifierProvider(create: (context) => LoginController()),
        ChangeNotifierProvider(create: (context) => ConnectivityProvider())
      ],
      child: Consumer<ConnectivityProvider>(
        builder: (context, connectivityProvider, child) {
          connectivityProvider.startMonitoring();
          return MaterialApp(
            title: 'Zoftcares Demo',
            theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true),
            onGenerateRoute: Routes.generateRoute,
            initialRoute: initailRoute,
          );
        },
      ),
    );
  }
}
