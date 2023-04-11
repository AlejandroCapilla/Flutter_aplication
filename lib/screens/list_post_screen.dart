import 'package:flutter/material.dart';
import 'package:flutter_demo/database/database_helper.dart';
import 'package:flutter_demo/provider/flags_provider.dart';
import 'package:provider/provider.dart';

import '../models/post_model.dart';
import '../widgets/item_post_widget.dart';

class ListPostScreen extends StatefulWidget {
  const ListPostScreen({super.key});

  @override
  State<ListPostScreen> createState() => _ListPostScreenState();
}

class _ListPostScreenState extends State<ListPostScreen> {
  DatabaseHelper? helper;

  @override
  void initState() {
    super.initState();
    helper = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    var futPost = helper!.GETALLPOST();

    return FutureBuilder(
      future: futPost,
      builder: (context, AsyncSnapshot<List<PostModel>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var objPostModel = snapshot.data![index];
              return ItemPostWidget(postModel: objPostModel);
            },
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Somethhing was wrong'),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
