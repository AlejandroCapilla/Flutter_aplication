import 'package:concentric_transition/page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/widgets/card_info.dart';
import 'package:lottie/lottie.dart';

class ConcentricTrasition extends StatelessWidget {
  ConcentricTrasition({super.key});
  final data = [
    CardInfoData(
        title: "TECNM en Celaya",
        subtitle: "El mejor tecnologico del mundo mundial",
        image: AssetImage("assets/tecnm_logo.png"),
        backgroundColor: Colors.white,
        titleColor: Color.fromARGB(255, 22, 162, 48),
        subtitleColor: Color.fromARGB(255, 22, 162, 48),
        bacground: LottieBuilder.asset("assets/info_animation2.json")),
    CardInfoData(
        title: "Simbolos",
        subtitle: "Conoce a la mascota del ITC",
        image: AssetImage("assets/mascota.jpg"),
        backgroundColor: Color.fromARGB(255, 22, 162, 48),
        titleColor: Colors.white,
        subtitleColor: Colors.white,
        bacground: LottieBuilder.asset("assets/info_animation.json")),
    CardInfoData(
        title: "Carreras",
        subtitle: "Unete a una de nuestras carreras",
        image: AssetImage("assets/carreras.png"),
        backgroundColor: Colors.white,
        titleColor: Color.fromARGB(255, 22, 162, 48),
        subtitleColor: Color.fromARGB(255, 22, 162, 48),
        bacground: LottieBuilder.asset("assets/info_animation2.json"))
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConcentricPageView(
        colors: data.map((e) => e.backgroundColor).toList(),
        itemCount: data.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (index) {
          return CardInfo(data: data[index]);
        },
        onFinish: () {
          Navigator.pushNamed(context, '/login');
        },
      ),
    );
  }
}
