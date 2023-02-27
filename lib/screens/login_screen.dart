import 'package:flutter/material.dart';
import 'package:flutter_demo/widgets/loading_modal_widget.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final txtEmail = TextFormField(
        decoration: const InputDecoration(
            label: Text('Email User'), enabledBorder: OutlineInputBorder()));

    final txtPass = TextFormField(
      obscureText: true,
      decoration: const InputDecoration(
          label: Text('Password User'), enabledBorder: OutlineInputBorder()),
    );

    final spaceHorizontal = SizedBox(
      height: 10,
    );

    final btnLogin = SocialLoginButton(
        buttonType: SocialLoginButtonType.generalLogin,
        onPressed: () {
          isLoading = true;
          setState(() {});
          Future.delayed(Duration(milliseconds: 2000));
        });

    final btnGoogle = SocialLoginButton(
        buttonType: SocialLoginButtonType.google, onPressed: () {});

    final btnFacebook = SocialLoginButton(
        buttonType: SocialLoginButtonType.facebook, onPressed: () {});

    final txtRegister = Padding(
      padding: const EdgeInsets.all(20),
      child: TextButton(
        onPressed: () {
          Navigator.pushNamed(context, '/register');
        },
        child: const Text('Registrarse',
            style:
                TextStyle(decoration: TextDecoration.underline, fontSize: 15)),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            constraints: BoxConstraints.expand(),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/fondo.png'),
                    fit: BoxFit.cover,
                    opacity: 0.5)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      txtEmail,
                      spaceHorizontal,
                      txtPass,
                      spaceHorizontal,
                      btnLogin,
                      spaceHorizontal,
                      const Text('or'),
                      spaceHorizontal,
                      btnGoogle,
                      spaceHorizontal,
                      btnFacebook,
                      spaceHorizontal,
                      txtRegister
                    ],
                  ),
                  Positioned(
                    top: 40,
                    child: Image.asset(
                      'assets/itcelaya_logo.png',
                      height: 200,
                    ),
                  )
                ],
              ),
            ),
          ),
          isLoading ? const LoadingModalWidget() : Container(),
        ],
      ),
    );
  }
}
