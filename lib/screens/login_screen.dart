import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_demo/firebase/auth_service.dart';
import 'package:flutter_demo/provider/theme_provider.dart';
import 'package:flutter_demo/settings/styles.dart';
import 'package:flutter_demo/widgets/loading_modal_widget.dart';
import 'package:provider/provider.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:uni_links/uni_links.dart';
import '../responsive.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late StreamSubscription _subs;
  final AuthService authService = AuthService();
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    _initDeepLinkListener();
    super.initState();
  }

  void _initDeepLinkListener() async {
    _subs = getLinksStream().listen(
        (String link) {
          _checkDeepLink(link);
        } as void Function(String? event)?,
        cancelOnError: true);
  }

  void _checkDeepLink(String link) {
    if (link != null) {
      String code = link.substring(link.indexOf(RegExp('code=')) + 5);
      authService.loginWithGithub(code).then((firebaseUser) {
        print(firebaseUser.email);
        print(firebaseUser.photoURL);
        print("LOGGED IN AS: ${firebaseUser.displayName}");
      }).catchError((e) {
        print("LOGIN ERROR: " + e.toString());
      });
    }
  }

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

    final spaceVertical = SizedBox(
      width: 100,
    );

    final btnLogin = SocialLoginButton(
        buttonType: SocialLoginButtonType.generalLogin,
        onPressed: () {
          isLoading = true;
          setState(() {});
          Future.delayed(Duration(milliseconds: 2000)).then((value) {
            isLoading = false;
            setState(() {});
            Navigator.pushNamed(context, '/dash');
          });
        });

    final btnGoogle = SocialLoginButton(
        buttonType: SocialLoginButtonType.google,
        onPressed: () {
          AuthService().googleLogin();
        });

    final btnFacebook = SocialLoginButton(
        buttonType: SocialLoginButtonType.github,
        onPressed: () {
          AuthService().githubLogin();
        });

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
        body: Responsive(
            mobile: MobileWelcomeScreen(
                txtEmail: txtEmail,
                spaceHorizontal: spaceHorizontal,
                txtPass: txtPass,
                btnLogin: btnLogin,
                btnGoogle: btnGoogle,
                btnFacebook: btnFacebook,
                txtRegister: txtRegister,
                isLoading: isLoading),
            desktop: Container(
              constraints: BoxConstraints.expand(),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/fondo.png'),
                      fit: BoxFit.cover,
                      opacity: 0.5)),
              child: Row(
                children: [
                  spaceVertical,
                  Positioned(
                    top: 40,
                    left: 40,
                    child: Image.asset(
                      'assets/itcelaya_logo.png',
                      height: 400,
                    ),
                  ),
                  spaceVertical,
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                  ),
                  spaceVertical
                ],
              ),
            )));
  }
}

class MobileWelcomeScreen extends StatelessWidget {
  const MobileWelcomeScreen({
    super.key,
    required this.txtEmail,
    required this.spaceHorizontal,
    required this.txtPass,
    required this.btnLogin,
    required this.btnGoogle,
    required this.btnFacebook,
    required this.txtRegister,
    required this.isLoading,
  });

  final TextFormField txtEmail;
  final SizedBox spaceHorizontal;
  final TextFormField txtPass;
  final SocialLoginButton btnLogin;
  final SocialLoginButton btnGoogle;
  final SocialLoginButton btnFacebook;
  final Padding txtRegister;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Stack(
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
    );
  }
}
