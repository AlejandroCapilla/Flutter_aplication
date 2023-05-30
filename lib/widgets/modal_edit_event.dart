import 'package:flutter/material.dart';
import 'package:flutter_demo/database/events_database_helper.dart';
import 'package:flutter_demo/globals.dart';
import 'package:flutter_demo/models/events_model.dart';

class ModalEditEvent extends StatefulWidget {
  ModalEditEvent({super.key, this.event});

  EventModel? event;

  @override
  State<ModalEditEvent> createState() => _ModalEditEventState();
}

class _ModalEditEventState extends State<ModalEditEvent> {
  EventsDatabaseHelper? database;
  TextEditingController txtDescEvent = TextEditingController();

  @override
  void initState() {
    super.initState();
    database = EventsDatabaseHelper();
    txtDescEvent.text = widget.event!.dscEvento!;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Event'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: txtDescEvent,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Completado',
              ),
              Switch(
                value: widget.event!.completado,
                onChanged: (value) {
                  setState(() {
                    widget.event!.completado = value;
                  });
                },
              ),
            ],
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            database!
                .ELIMINAR('tblEvento', widget.event!.idEvento!)
                .then((value) {});
            database!.INSERTAR('tblEvento', {
              'dscEvento': txtDescEvent.text,
              'fechaEvento': widget.event!.fechaEvento,
              'completado': widget.event!.completado ? 1 : 0
            }).then((value) {
              var msg = value > 0 ? 'Registro actualizado' : 'Ocurrio un error';

              final snackBar = SnackBar(content: Text(msg));
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              actEvents.value++;
            });
          },
          child: const Text('Save'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        )
      ],
    );
  }
}
