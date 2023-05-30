import 'package:flutter/material.dart';
import 'package:flutter_demo/database/events_database_helper.dart';
import 'package:flutter_demo/globals.dart';
import 'package:flutter_demo/models/events_model.dart';
import 'package:flutter_demo/provider/theme_provider.dart';
import 'package:flutter_demo/widgets/futures_modal.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  IconData _currentIcon = Icons.calendar_month;
  DateTime selectedDay = DateTime.now().toUtc();
  DateTime focusedDay = DateTime.now().toUtc();
  Map<DateTime, List<EventModel>>? selectedEvents;
  EventsDatabaseHelper? database;
  EventModel? evento;
  bool calendarView = true;

  @override
  void initState() {
    selectedEvents = {};
    super.initState();
    database = EventsDatabaseHelper();
  }

  List<EventModel> _getEventsfromDay(DateTime date) {
    return selectedEvents![date] ?? [];
  }

  Future<List<EventModel>> _getEventsfromDayList(DateTime date) async {
    final eventos =
        await database!.getEventsForDay('${date.toIso8601String()}Z');
    if (eventos.isNotEmpty) {
      return eventos;
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = Provider.of<ThemeProvider>(context);

    return SafeArea(
      child: ValueListenableBuilder(
        valueListenable: actEvents,
        builder: (context, value, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Events'),
            ),
            body: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                      alignment: Alignment.centerRight,
                      onPressed: () {
                        setState(() {
                          _currentIcon = (_currentIcon == Icons.calendar_month)
                              ? Icons.list
                              : Icons.calendar_month;
                          calendarView = !calendarView;
                        });
                      },
                      icon: Icon(_currentIcon)),
                ),
                FutureBuilder<List<EventModel>>(
                  future: database!.GETALLEVENTS(),
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return TableCalendar(
                        firstDay: DateTime.utc(2010, 10, 16),
                        lastDay: DateTime.utc(2030, 3, 14),
                        focusedDay: DateTime.now(),
                        selectedDayPredicate: (DateTime date) {
                          return isSameDay(selectedDay, date);
                        },
                      );
                    } else if (snapshot.hasData) {
                      selectedEvents = {};
                      for (var evento in snapshot.data!) {
                        DateTime fechaEvento =
                            DateTime.parse(evento.fechaEvento!).toUtc();
                        if (selectedEvents![fechaEvento] == null) {
                          selectedEvents![fechaEvento] = [];
                        }
                        selectedEvents![fechaEvento]!.add(evento);
                      }

                      return calendarView
                          ? TableCalendar(
                              firstDay: DateTime.utc(2010, 10, 16),
                              lastDay: DateTime.utc(2030, 3, 14),
                              focusedDay: DateTime.now(),
                              onDaySelected:
                                  (DateTime selectDay, DateTime focusDay) {
                                setState(() {
                                  selectedDay = selectDay;
                                  focusedDay = focusDay;
                                });
                              },
                              selectedDayPredicate: (DateTime date) {
                                return isSameDay(selectedDay, date);
                              },
                              eventLoader: _getEventsfromDay,
                              calendarStyle: CalendarStyle(
                                isTodayHighlighted: true,
                                selectedTextStyle:
                                    const TextStyle(color: Colors.white),
                                todayDecoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  shape: BoxShape.circle,
                                ),
                                defaultDecoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                defaultTextStyle: TextStyle(
                                  color: theme.getTheme() == 'oscuro'
                                      ? Colors.white
                                      : Colors.black,
                                ),
                                weekendDecoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                              ),
                              calendarBuilders: CalendarBuilders(
                                markerBuilder: (context, date, events) {
                                  BoxDecoration? decoration;
                                  TextStyle? textStyle;
                                  if (events.isNotEmpty) {
                                    int difDias = date
                                            .difference(DateTime.now().toUtc())
                                            .inDays +
                                        1;
                                    EventModel event = events[0] as EventModel;
                                    bool? completado = event.completado;
                                    if (difDias == 0) {
                                      decoration = const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color.fromARGB(255, 90, 255, 95),
                                      );
                                      textStyle = const TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0));
                                    } else if (difDias < 0 && completado) {
                                      decoration = const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color.fromARGB(255, 90, 255, 95),
                                      );
                                      textStyle = const TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0));
                                    } else if (difDias < 0 && !completado) {
                                      decoration = const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color.fromARGB(223, 255, 33, 33),
                                      );
                                      textStyle = const TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0));
                                    } else if (difDias == 1) {
                                      decoration = const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color:
                                            Color.fromARGB(255, 250, 233, 81),
                                      );
                                      textStyle = const TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0));
                                    } else if (events.isNotEmpty) {
                                      decoration = const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color:
                                            Color.fromARGB(255, 59, 176, 255),
                                      );
                                      textStyle =
                                          const TextStyle(color: Colors.black);
                                    }
                                  }
                                  return Container(
                                    width: 50,
                                    height: 50,
                                    decoration: decoration,
                                    child: Center(
                                      child: Text(
                                          events.isNotEmpty
                                              ? '${date.day}'
                                              : '',
                                          style: textStyle),
                                    ),
                                  );
                                },
                              ))
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: 30,
                              itemBuilder: (context, index) {
                                final day = DateTime.now()
                                    .toUtc()
                                    .add(Duration(days: index));
                                final fecha =
                                    DateFormat('yyyy-MM-dd').format(day);
                                return FutureBuilder<List<EventModel>>(
                                  future: _getEventsfromDayList(
                                      DateTime.parse(fecha)),
                                  builder: ((context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Container();
                                    }
                                    final events = snapshot.data ?? [];
                                    return Column(
                                      children: [
                                        if (events.isNotEmpty)
                                          Divider(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimaryContainer,
                                            height: 1,
                                          ),
                                        ...events.map(
                                          (event) => ListTile(
                                            title: Text(
                                                event.dscEvento.toString()),
                                            subtitle: Text(
                                              DateFormat('MMMM d').format(day),
                                            ),
                                            trailing: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                IconButton(
                                                  icon: const Icon(
                                                    Icons.edit,
                                                    color: Color.fromARGB(
                                                        255, 253, 245, 100),
                                                  ),
                                                  onPressed: () =>
                                                      openCustomeEditEventDialog(
                                                          context, event),
                                                ),
                                                IconButton(
                                                  icon: const Icon(Icons.delete,
                                                      color: Color.fromARGB(
                                                          255, 255, 99, 99)),
                                                  onPressed: () {
                                                    showDialog(
                                                        context: context,
                                                        builder:
                                                            (context) =>
                                                                AlertDialog(
                                                                  title: const Text(
                                                                      'Advertencia'),
                                                                  content:
                                                                      const Text(
                                                                          'Desea eliminar este evento?'),
                                                                  actions: [
                                                                    TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          database!
                                                                              .ELIMINAR('tblEvento', event.idEvento!)
                                                                              .then((value) {
                                                                            setState(() {});
                                                                          });
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        child: const Text(
                                                                            'Yes')),
                                                                    TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        child: const Text(
                                                                            'No'))
                                                                  ],
                                                                ));
                                                  },
                                                )
                                              ],
                                            ),
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      AlertDialog(
                                                        content: Text(event
                                                            .dscEvento
                                                            .toString()),
                                                      ));
                                            },
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                                );
                              });
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text("Error: ${snapshot.error}"),
                      );
                    } else {
                      return const Center(
                        child: Text("No events found."),
                      );
                    }
                  }),
                  //me falta completar esta cosa y mandar la fecha en al modal events
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton.extended(
                onPressed: () => openCustomeEventDialog(context, selectedDay),
                icon: const Icon(Icons.add),
                label: const Text('Add event')),
          );
        },
      ),
    );
  }
}
