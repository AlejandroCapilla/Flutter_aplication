import 'dart:io';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/firebase/email_auth.dart';
import 'package:flutter_demo/screens/select_photo_options_screen.dart';
import 'package:image_picker/image_picker.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static const id = 'set_photo_screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  File? _image;

  EmailAuth emailAuth = EmailAuth();

  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);
      setState(() {
        _image = img;
        Navigator.of(context).pop();
      });
    } on PlatformException catch (e) {
      print(e);
      Navigator.of(context).pop();
    }
  }

  void _showSelectPhotoOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.28,
          maxChildSize: 0.4,
          minChildSize: 0.28,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: SelectPhotoOptionsScreen(
                onTap: _pickImage,
              ),
            );
          }),
    );
  }

  bool checkTextFields() {
    if (userNameController.text.trim() != '' &&
        EmailValidator.validate(emailController.text) &&
        passwordController.text.trim() != '') {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final txtNombre = TextFormField(
      controller: userNameController,
      decoration: const InputDecoration(
          label: Text('Name'), enabledBorder: OutlineInputBorder()),
    );

    final txtCorreo = TextFormField(
      controller: emailController,
      decoration: const InputDecoration(
          label: Text('Email'), enabledBorder: OutlineInputBorder()),
    );

    final txtPass = TextFormField(
      controller: passwordController,
      obscureText: true,
      decoration: const InputDecoration(
          label: Text('Password User'), enabledBorder: OutlineInputBorder()),
    );

    final txtRegister = Padding(
      padding: const EdgeInsets.all(20),
      child: TextButton(
        onPressed: () {
          if (checkTextFields()) {
            emailAuth.createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Ingrese valores validos :)')));
          }
        },
        child: const Text('Registrarse',
            style: TextStyle(
                decoration: TextDecoration.underline,
                fontSize: 25,
                color: Color.fromARGB(255, 40, 60, 100))),
      ),
    );

    final spaceHorizontal = SizedBox(
      height: 10,
    );

    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/fondo.png'),
                fit: BoxFit.cover,
                opacity: 0.2)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: Center(
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          _showSelectPhotoOptions(context);
                        },
                        child: Center(
                          child: Container(
                              height: 130.0,
                              width: 130.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.shade200,
                              ),
                              child: Center(
                                child: _image == null
                                    ? const Text(
                                        'No image selected',
                                        style: TextStyle(fontSize: 20),
                                        textAlign: TextAlign.center,
                                      )
                                    : CircleAvatar(
                                        backgroundImage: FileImage(_image!),
                                        radius: 200.0,
                                      ),
                              )),
                        ),
                      ),
                    ),
                  ),
                  txtNombre,
                  spaceHorizontal,
                  txtCorreo,
                  spaceHorizontal,
                  txtPass,
                  txtRegister
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
