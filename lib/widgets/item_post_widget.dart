import 'package:flutter/material.dart';
import '../models/post_model.dart';

class ItemPostWidget extends StatelessWidget {
  ItemPostWidget({super.key, this.postModel});

  PostModel? postModel;

  @override
  Widget build(BuildContext context) {
    final iconMore = Icon(
      Icons.more_horiz,
      size: 35,
    );
    final cardDesc = Container(
      height: 180,
      color: Colors.green,
    );

    final rowFoter = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text('Fecha:'), Icon(Icons.thumb_up)],
    );

    final ribbonTop = ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      child: Container(
        padding: EdgeInsets.only(right: 10),
        alignment: Alignment.centerRight,
        height: 60,
        width: double.infinity,
        child: iconMore,
        color: Colors.green[200],
      ),
    );

    final ribbonBottom = ClipRRect(
      borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.centerRight,
        height: 60,
        width: double.infinity,
        child: rowFoter,
        color: Colors.green[200],
      ),
    );

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 280,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(color: Colors.grey, blurRadius: 8, offset: Offset(0, 4)),
        ], color: Colors.green, borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [ribbonTop, cardDesc, ribbonBottom],
        ),
      ),
    );
  }
}
