import 'package:flutter/material.dart';

class ActorCard extends StatelessWidget {
  final String name;
  final String photoUrl;

  const ActorCard({
    Key? key,
    required this.name,
    required this.photoUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String photo = photoUrl.toString().contains('originalnull')
        ? 'https://definicion.de/wp-content/uploads/2019/07/perfil-de-usuario.png'
        : photoUrl;

    return Container(
      margin: const EdgeInsets.only(right: 15),
      child: Column(
        children: [
          ClipOval(
            child: Image.network(
              photo,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: 100,
            child: Text(
              name,
              style: const TextStyle(
                  fontSize: 12,
                  decoration: TextDecoration.none,
                  color: Colors.white70),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
