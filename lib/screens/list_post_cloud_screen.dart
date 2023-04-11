import 'package:flutter/material.dart';
import 'package:flutter_demo/firebase/post_collection.dart';
import 'package:flutter_demo/models/post_model.dart';
import 'package:flutter_demo/widgets/item_post_widget.dart';

class ListPostCloudScreen extends StatefulWidget {
  const ListPostCloudScreen({super.key});

  @override
  State<ListPostCloudScreen> createState() => _ListPostCloudScreenState();
}

class _ListPostCloudScreenState extends State<ListPostCloudScreen> {
  PostColleciton? postColleciton;

  @override
  void initState() {
    super.initState();
    postColleciton = PostColleciton();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: postColleciton!.getAllPosts(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final dscPost = snapshot.data!.docs[index].get('dscPost');
              final datePost = snapshot.data!.docs[index].get('datePost');
              return ItemPostWidget(
                postModel:
                    PostModel(dscPost: dscPost, datePost: datePost.toString()),
              );
            },
          );
          //} else if (No se que iba aqui alv){
          //return Center(child: Text('Algo salio mal! :c'))
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
