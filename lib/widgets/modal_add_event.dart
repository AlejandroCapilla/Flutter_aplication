import 'package:flutter/material.dart';
import 'package:flutter_demo/database/database_helper.dart';
import 'package:flutter_demo/database/events_database_helper.dart';
import 'package:flutter_demo/models/events_model.dart';
import 'package:provider/provider.dart';
import '../provider/flags_provider.dart';

class ModalAddEvent extends StatefulWidget {
  ModalAddEvent({super.key, this.day});

  DateTime? day;

  @override
  State<ModalAddEvent> createState() => _ModalAddEventState();
}

class _ModalAddEventState extends State<ModalAddEvent> {
  EventsDatabaseHelper? database;
  TextEditingController txtDescEvent = TextEditingController();

  @override
  void initState() {
    super.initState();
    database = EventsDatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    FlagsProvider flags = Provider.of<FlagsProvider>(context);

    return AlertDialog(
      title: const Text('Add Event'),
      content: SizedBox(
        height: 170,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextFormField(
              controller: txtDescEvent,
              maxLines: 5,
            ),
            IconButton(
                onPressed: () {
                  database!.INSERTAR('tblEvento', {
                    'dscEvento': txtDescEvent.text,
                    'fechaEvento': widget.day!.toIso8601String(),
                    'completado': 0
                  });
                  Navigator.pop(context);
                  setState(() {});
                },
                icon: const Icon(Icons.add))
          ],
        ),
      ),
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
}
