import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_demo/models/post_model.dart';

class PostColleciton {
  late FirebaseFirestore? _firestore;
  CollectionReference? _postCollection;

  PostColleciton() {
    _firestore = FirebaseFirestore.instance;
    _postCollection = _firestore!.collection('posts');
  }

  Future<void> insertPost(PostModel postModel) async {
    return _postCollection!
        .doc()
        .set({'dscPost': postModel.dscPost, 'datePost': postModel.datePost});
  }

  Future<void> updatePost(PostModel postModel, String id) async {
    return _postCollection!
        .doc(id)
        .update({'dscPost': postModel.dscPost, 'datePost': postModel.datePost});
  }

  Future<void> deletePost(String id) async {
    return _postCollection!.doc(id).delete();
  }

  Stream<QuerySnapshot> getAllPosts() {
    return _postCollection!.snapshots();
  }
}
