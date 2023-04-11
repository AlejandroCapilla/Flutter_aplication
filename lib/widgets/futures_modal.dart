import 'package:flutter/material.dart';

import '../models/post_model.dart';
import 'modal_add_post.dart';

openCustomeDialog(BuildContext context, PostModel? postModel) {
  return showGeneralDialog(
    context: context,
    barrierColor: Color.fromARGB(255, 30, 233, 152).withOpacity(.5),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return Transform.scale(
        scale: animation.value,
        child: Opacity(
          opacity: animation.value,
          child: ModalAddPost(
            postModel: postModel,
          ),
        ),
      );
    },
    transitionDuration: const Duration(milliseconds: 200),
    barrierDismissible: true,
    barrierLabel: '',
    pageBuilder: (context, animation, secondaryAnimation) {
      return Container();
    },
  );
}
