import 'package:flutter/material.dart';
import 'package:flutter_demo/database/database_helper.dart';
import 'package:flutter_demo/widgets/futures_modal.dart';
import 'package:provider/provider.dart';
import '../models/post_model.dart';
import '../provider/flags_provider.dart';

class ItemPostWidget extends StatelessWidget {
  ItemPostWidget({super.key, this.postModel});

  DatabaseHelper _database = DatabaseHelper();
  PostModel? postModel;
  FlagsProvider? flags;

  @override
  Widget build(BuildContext context) {
    flags = Provider.of<FlagsProvider>(context);
    final iconMore = Icon(
      Icons.more_horiz,
      size: 35,
    );
    final cardDesc = Container(
      padding: const EdgeInsets.all(10),
      alignment: Alignment.topLeft,
      height: 170,
      color: Colors.green,
      child: Text('${postModel!.dscPost}'),
    );

    final rowFoter = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Fecha: ${postModel!.datePost}',
          style: TextStyle(fontSize: 18),
        ),
        Icon(Icons.thumb_up)
      ],
    );

    final ribbonTop = ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      child: Container(
        padding: EdgeInsets.only(right: 10),
        alignment: Alignment.centerRight,
        height: 50,
        width: double.infinity,
        color: Colors.green[200],
        child: PopupMenuButton(
          icon: iconMore,
          itemBuilder: (context) {
            return const [
              PopupMenuItem(child: Text('Editar'), value: 0),
              PopupMenuItem(child: Text('Borrar'), value: 1)
            ];
          },
          onSelected: (value) {
            switch (value) {
              case 0:
                openCustomeDialog(context, postModel);
                break;
              case 1:
                _showDeleteModal(context);
                break;
              default:
            }
          },
        ),
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

  _showDeleteModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: const Text('Deseas borrar el post?'),
          actions: [
            TextButton(
                onPressed: () {
                  _database.ELIMINAR('tblPost', postModel!.idPost!);
                  Navigator.pop(context);
                  flags!.setupdatePosts();
                },
                child: Text('OK')),
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancelar')),
          ],
        );
      },
    );
  }
}
