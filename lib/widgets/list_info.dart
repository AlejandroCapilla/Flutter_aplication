import 'package:flutter/material.dart';
import 'package:flutter_demo/models/deezer_model.dart';

class ListInfo extends StatefulWidget {
  ListInfo({super.key, required this.deezerModel, required this.index});
  DeezerModel? deezerModel;
  int index;
  @override
  State<ListInfo> createState() => _ListInfoState();
}

class _ListInfoState extends State<ListInfo> with TickerProviderStateMixin {
  late final AnimationController _controllerText = AnimationController(
    duration: const Duration(seconds: 4),
    vsync: this,
  );
  late final Animation<double> _animationText =
      Tween(begin: 0.0, end: 1.0).animate(_controllerText);

  @override
  void initState() {
    super.initState();
    _controllerText.forward();
  }

  @override
  void dispose() {
    _controllerText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.index == 0) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: FadeTransition(
          opacity: _animationText,
          child: Text(widget.deezerModel!.title!,
              textAlign: TextAlign.left,
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 26,
                  color: Colors.white,
                  decoration: TextDecoration.none)),
        ),
      );
    } else if (widget.index == 1) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: FadeTransition(
          opacity: _animationText,
          child: Text('rank: ${widget.deezerModel!.rank}',
              textAlign: TextAlign.left,
              style: const TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 18,
                  color: Colors.white,
                  decoration: TextDecoration.none)),
        ),
      );
    } else if (widget.index == 2) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
        child: FadeTransition(
          opacity: _animationText,
          child: ListTile(
            leading: CircleAvatar(
                backgroundImage:
                    NetworkImage(widget.deezerModel!.artist!.pictureSmall)),
            title: Text(widget.deezerModel!.artist!.name,
                textAlign: TextAlign.left,
                style: const TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 18,
                    color: Colors.white,
                    decoration: TextDecoration.none)),
          ),
        ),
      );
    } else if (widget.index == 3) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: FadeTransition(
          opacity: _animationText,
          child: Text('Album: ${widget.deezerModel!.album!.title}',
              textAlign: TextAlign.left,
              style: const TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 18,
                  color: Colors.white,
                  decoration: TextDecoration.none)),
        ),
      );
    } else if (widget.index == 4) {
      int totalSeconds = widget.deezerModel!.duration!;
      int minutes = totalSeconds ~/ 60; // Obtiene la cantidad de minutos
      int seconds = totalSeconds % 60;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: FadeTransition(
          opacity: _animationText,
          child: Text('Duration: $minutes minutes y $seconds seconds',
              textAlign: TextAlign.left,
              style: const TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 18,
                  color: Colors.white,
                  decoration: TextDecoration.none)),
        ),
      );
    }

    return const SizedBox(
      height: 40,
    );
  }
}
