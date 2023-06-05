import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/models/deezer_model.dart';
import 'package:flutter_demo/widgets/list_info.dart';
import 'package:just_audio/just_audio.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:rxdart/rxdart.dart';

class PlayMusicScreen extends StatefulWidget {
  PlayMusicScreen({super.key, required this.deezerModel});

  DeezerModel? deezerModel;
  @override
  State<PlayMusicScreen> createState() => _PlayMusicScreenState();
}

class _PlayMusicScreenState extends State<PlayMusicScreen>
    with TickerProviderStateMixin {
  late AudioPlayer _audioPlayer;
  Color? colorAccent;

  late final AnimationController _controllerText = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  );
  late final Animation<double> _animationText =
      Tween(begin: 0.0, end: 1.0).animate(_controllerText);

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        _audioPlayer.positionStream,
        _audioPlayer.bufferedPositionStream,
        _audioPlayer.durationStream,
        (position, bufferedPosition, duration) =>
            PositionData(position, bufferedPosition, duration ?? Duration.zero),
      );

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer()..setUrl(widget.deezerModel!.preview!);
    _controllerText.forward();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
    _controllerText.dispose();
  }

  Future<Color?> obtenerColor() async {
    PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(
            NetworkImage(widget.deezerModel!.album!.coverSmall));
    colorAccent = paletteGenerator.dominantColor?.color;
    return colorAccent;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: FutureBuilder(
        future: obtenerColor(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      snapshot.data!,
                      Colors.black,
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 140,
                        ),
                        Center(
                          child: Hero(
                            tag: widget.deezerModel!.id!,
                            child: Image(
                              image: NetworkImage(
                                  widget.deezerModel!.album!.coverBig),
                              width: 290,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 80,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: FadeTransition(
                            opacity: _animationText,
                            child: Text(
                              widget.deezerModel!.title!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  color: Colors.white,
                                  decoration: TextDecoration.none),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: FadeTransition(
                            opacity: _animationText,
                            child: Text(widget.deezerModel!.artist!.name,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.white,
                                    decoration: TextDecoration.none)),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FadeTransition(
                          opacity: _animationText,
                          child: StreamBuilder(
                            stream: _positionDataStream,
                            builder: (context, snapshot) {
                              final positionData = snapshot.data;
                              return Center(
                                child: SizedBox(
                                  width: 290,
                                  child: ProgressBar(
                                    barHeight: 5,
                                    thumbColor: colorAccent,
                                    progressBarColor: colorAccent,
                                    baseBarColor: Colors.grey[800],
                                    bufferedBarColor: Colors.grey[700],
                                    progress:
                                        positionData?.position ?? Duration.zero,
                                    buffered: positionData?.bufferedPosition ??
                                        Duration.zero,
                                    total:
                                        positionData?.duration ?? Duration.zero,
                                    onSeek: _audioPlayer.seek,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Center(
                          child: Material(
                              color: Colors.transparent,
                              child: Controls(audioPlayer: _audioPlayer)),
                        )
                      ],
                    ),
                    DraggableScrollableSheet(
                        initialChildSize: 0.06,
                        minChildSize: 0.05,
                        maxChildSize: 0.35,
                        builder: (context, scrollController) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: colorAccent,
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15))),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                controller: scrollController,
                                itemCount: 6,
                                itemBuilder: (context, index) {
                                  return ListInfo(
                                      deezerModel: widget.deezerModel,
                                      index: index);
                                },
                              ),
                            ),
                          );
                        }),
                  ],
                ));
          } else {
            return const SizedBox(
                height: 203, child: Center(child: CircularProgressIndicator()));
          }
        },
      ),
    );
  }
}

class Controls extends StatelessWidget {
  const Controls({super.key, required this.audioPlayer});
  final AudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: audioPlayer.playerStateStream,
        builder: (context, snapshot) {
          final playerState = snapshot.data;
          final processingState = playerState?.processingState;
          final playng = playerState?.playing;
          if (!(playng ?? false)) {
            return IconButton(
              onPressed: audioPlayer.play,
              iconSize: 80,
              color: Colors.white,
              icon: const Icon(Icons.play_arrow_rounded),
            );
          } else if (processingState != ProcessingState.completed) {
            return IconButton(
              onPressed: audioPlayer.pause,
              iconSize: 80,
              color: Colors.white,
              icon: const Icon(Icons.pause_rounded),
            );
          }
          return const Icon(
            Icons.play_arrow_rounded,
            size: 80,
            color: Colors.white,
          );
        });
  }
}

class PositionData {
  const PositionData(
    this.position,
    this.bufferedPosition,
    this.duration,
  );

  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;
}
