import 'package:flutter/material.dart';
import 'package:flutter_demo/models/deezer_model.dart';
import 'package:flutter_demo/screens/play_music_screen.dart';

class ItemDeezer extends StatelessWidget {
  ItemDeezer({super.key, required this.deezerModel});

  DeezerModel? deezerModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    PlayMusicScreen(deezerModel: deezerModel))),
        child: SizedBox(
          height: 50,
          child: Row(
            children: [
              Hero(
                  tag: deezerModel!.id!,
                  child: FadeInImage(
                      width: 80,
                      height: 80,
                      placeholder:
                          const AssetImage('assets/loading_deezer.gif'),
                      image: NetworkImage(deezerModel!.album!.coverMedium))),
              const SizedBox(
                width: 15,
              ),
              SizedBox(
                width: 220,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      deezerModel!.title!,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(deezerModel!.artist!.name)
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
