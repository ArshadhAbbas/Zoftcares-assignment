import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoftcares/constants/app_constants.dart';
import 'package:zoftcares/constants/extensions.dart';
import 'package:zoftcares/controller/login_controller.dart';
import 'package:zoftcares/controller/session_controller.dart';
import 'package:zoftcares/models/version.dart';
import 'package:zoftcares/repository/login_repo/login_repo.dart';
import 'package:zoftcares/view/login/widget/auth_text_field.dart';
import 'package:zoftcares/view/login/widget/version_widget.dart';
import 'package:zoftcares/view/posts/view/posts_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});
  static const routePath = "/";

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  late Future<VersionModel> versionModel;
  @override
  void initState() {
    versionModel = LoginRepo().getVersion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Form(
            key: loginKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  VersionWidget(versionModel: versionModel),
                  const SizedBox(height: 20),
                  AuthTextFiled(
                    controller: emailController,
                    inputType: TextInputType.emailAddress,
                    hintText: "E-Mail",
                    validator: (value) {
                      if (value!.isEmpty || !value.contains("@")) {
                        return "Please Enter a valid Email Id";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  AuthTextFiled(
                    controller: passwordController,
                    inputType: TextInputType.text,
                    hintText: "Password",
                    isPassword: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Password";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Consumer<LoginController>(
                    builder: (context, loginController, child) {
                      return ElevatedButton(
                          onPressed: () async {
                            if (!loginController.isLoading) {
                              _login(context);
                            }
                          },
                          child: !loginController.isLoading
                              ? const Text("Login")
                              : const CircularProgressIndicator());
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      // bottomSheet: VersionWidget(versionModel: versionModel),
    );
  }

  void _login(BuildContext context) {
    if (loginKey.currentState!.validate()) {
      context.read<LoginController>().changeIsLoading();
      AppConstants.dismissKeyboard();
      LoginRepo()
          .login(emailController.text.trim(), passwordController.text.trim())
          .then(
        (value) async {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          if (context.mounted) {
            context.read<LoginController>().changeIsLoading();
          }
          if (value.status != null && value.status == true) {
            if (value.data != null) {
              await prefs.setString('accessToken', value.data!.accessToken!);
              await prefs.setString(
                  'timeOut',
                  DateTime.now()
                      .add(
                          Duration(milliseconds: value.data!.validity!.toInt()))
                      .toString());
              if (context.mounted) {
                context
                    .read<SessionController>()
                    .resetSession(value.data!.validity!);
                Navigator.pushReplacementNamed(context, PostsView.routePath);
              }
            }
          } else if ((value.status != null && value.status == false) ||
              value.data == null) {
            if (context.mounted) {
              context.showSnackbarExtension("Check the credentials");
            }
          }
        },
      ).onError(
        (error, stackTrace) {
          context.showSnackbarExtension("Check the credentials");
        },
      );
    }
  }
}
