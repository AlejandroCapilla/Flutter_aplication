import 'package:flutter/material.dart';
import 'package:flutter_demo/models/events_model.dart';
import '../models/post_model.dart';
import 'modal_add_post.dart';
import 'modal_add_event.dart';
import 'modal_edit_event.dart';

openCustomePostDialog(BuildContext context, PostModel? postModel) {
  return showGeneralDialog(
    context: context,
    barrierColor: Color.fromARGB(255, 69, 94, 84).withOpacity(.5),
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

openCustomeEventDialog(BuildContext context, DateTime day) {
  return showGeneralDialog(
    context: context,
    barrierColor: Color.fromARGB(255, 69, 94, 84).withOpacity(.5),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return Transform.scale(
        scale: animation.value,
        child: Opacity(
          opacity: animation.value,
          child: ModalAddEvent(day: day),
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

openCustomeEditEventDialog(BuildContext context, EventModel event) {
  return showGeneralDialog(
    context: context,
    barrierColor: Color.fromARGB(255, 69, 94, 84).withOpacity(.5),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return Transform.scale(
        scale: animation.value,
        child: Opacity(
          opacity: animation.value,
          child: ModalEditEvent(
            event: event,
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
