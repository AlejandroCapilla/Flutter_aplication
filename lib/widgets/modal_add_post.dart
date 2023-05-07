import 'package:flutter/material.dart';
import 'package:flutter_demo/database/database_helper.dart';
import 'package:flutter_demo/firebase/post_collection.dart';
import 'package:flutter_demo/models/post_model.dart';
import 'package:provider/provider.dart';
import '../provider/flags_provider.dart';

class ModalAddPost extends StatefulWidget {
  ModalAddPost({super.key, this.postModel});

  PostModel? postModel;

  @override
  State<ModalAddPost> createState() => _ModalAddPostState();
}

class _ModalAddPostState extends State<ModalAddPost> {
  DatabaseHelper? database;
  TextEditingController txtDescPost = TextEditingController();
  PostCollection? postCollection;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    database = DatabaseHelper();
    postCollection = PostCollection();
    txtDescPost.text =
        widget.postModel != null ? widget.postModel!.datePost! : '';
  }

  @override
  Widget build(BuildContext context) {
    FlagsProvider flags = Provider.of<FlagsProvider>(context);

    return AlertDialog(
      title:
          widget.postModel == null ? Text('Adding Post') : Text('Editing Post'),
      content: SizedBox(
        height: 170,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextFormField(
              controller: txtDescPost,
              maxLines: 5,
            ),
            IconButton(
                onPressed: () {
                  if (widget.postModel == null) {
                    postCollection!
                        .insertPost(PostModel(
                            dscPost: txtDescPost.text,
                            datePost: DateTime.now().toString()))
                        .then((value) {
                      var msg = 'Registro insertado';

                      final snackBar = SnackBar(content: Text(msg));
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      flags.setupdatePosts();
                    });
                    // database!.INSERTAR('tblPost', {
                    //   'dscPost': txtDescPost.text,
                    //   'datePost': DateTime.now().toString()
                    // }).then((value) {
                    //   var msg =
                    //       value > 0 ? 'Registro insertado' : 'Ocurrio un error';

                    //   final snackBar = SnackBar(content: Text(msg));
                    //   Navigator.pop(context);
                    //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    //   flags.setupdatePosts();
                    // });
                  } else {
                    postCollection!
                        .updatePost(
                            PostModel(
                                dscPost: txtDescPost.text,
                                datePost: DateTime.now().toString()),
                            widget.postModel!.idPost.toString())
                        .then((value) {
                      var msg = 'Registro insertado';

                      final snackBar = SnackBar(content: Text(msg));
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      flags.setupdatePosts();
                    });
                    // database!.ACTUALIZAR('tblPost', {
                    //   'idPost': widget.postModel!.idPost,
                    //   'dscPost': txtDescPost.text,
                    //   'datePost': DateTime.now().toString()
                    // }).then((value) {
                    //   var msg = value > 0
                    //       ? 'Registro actualizado'
                    //       : 'Ocurrio un error';

                    //   final snackBar = SnackBar(content: Text(msg));
                    //   Navigator.pop(context);
                    //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    //   flags.setupdatePosts();
                    // });
                  }
                },
                icon: Icon(Icons.send))
          ],
        ),
      ),
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
}
