import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
//nombre, correo, avatar

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    final btnUserAvatar = CircularProfileAvatar(
      'https://avatars0.githubusercontent.com/u/8264639?s=460&v=4',
      radius: 100,
      backgroundColor: Colors.transparent,
      borderWidth: 10,
      borderColor: Colors.green,
      elevation: 5.0,
      onTap: () {
        print('adil');
      },
    );

    final txtNombre = TextFormField(
      decoration: const InputDecoration(
          label: Text('Name'), enabledBorder: OutlineInputBorder()),
    );

    final txtCorreo = TextFormField(
      decoration: const InputDecoration(
          label: Text('Email'), enabledBorder: OutlineInputBorder()),
    );

    final spaceHorizontal = SizedBox(
      height: 10,
    );

    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('fondo.png'),
                fit: BoxFit.cover,
                opacity: 0.5)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  btnUserAvatar,
                  spaceHorizontal,
                  txtNombre,
                  spaceHorizontal,
                  txtCorreo,
                ],
              ),
              Positioned(
                top: 50,
                child: Image.asset(
                  'assets/itcelaya_logo.png',
                  height: 150,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
