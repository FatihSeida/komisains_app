import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:komisains_app/modules/agenda/bloc/agenda_bloc.dart';
import 'package:add_2_calendar/add_2_calendar.dart';

class ListAgenda extends StatefulWidget {
  @override
  _ListAgendaState createState() => _ListAgendaState();
}

class _ListAgendaState extends State<ListAgenda> {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  late AgendaBloc agendaBloc;

  @override
  void initState() {
    agendaBloc = context.read<AgendaBloc>();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    agendaBloc.add(FetchAgenda());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocBuilder<AgendaBloc, AgendaState>(
      builder: (context, state) {
        if (state is AgendaStateLoad) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is AgendaStateLoaded) {
          return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (ctx, index) {
              return OpenContainer<bool>(
                closedColor: Colors.transparent,
                closedElevation: 0,
                openBuilder: (context, openContainer) {
                  return Scaffold(
                    body: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 60,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: InkWell(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: const Icon(
                                  FontAwesomeIcons.arrowLeft,
                                  color: const Color(0xff3BBC86),
                                ),
                              ),
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              padding: const EdgeInsets.only(left: 15, top: 20),
                              child: Text(
                                state.calendar[index].name,
                                style: textTheme.headline5!.copyWith(
                                    color: const Color(0xff3BBC86),
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.8,
                              width: MediaQuery.of(context).size.width * 1,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(30)),
                                  child: Image.network(
                                    state.calendar[index].thumbnail,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20, bottom: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.calendar[index].description,
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(
                                    fontFamily: 'SourceSansPro',
                                    height: 1.5,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  'Tanggal/Waktu :',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${DateFormat.yMMMd('en_US').add_jm().format(state.calendar[index].dateStart)} ${state.calendar[index].waktuStart}',
                                ),
                                Text(
                                  'Tempat :',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${state.calendar[index].tempat}',
                                ),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    final startDate =
                                        '${DateFormat('yyyy-MM-dd').format(state.calendar[index].dateStart)} ${state.calendar[index].waktuStart}';
                                    final endDate =
                                        '${DateFormat('yyyy-MM-dd').format(state.calendar[index].dateEnd)} ${state.calendar[index].waktuEnd}';
                                    Add2Calendar.addEvent2Cal(
                                      Event(
                                          title: state.calendar[index].name,
                                          startDate: DateTime.parse(startDate),
                                          endDate: DateTime.parse(endDate),
                                          description:
                                              state.calendar[index].description,
                                          timeZone: "GMT+07:00",
                                          location:
                                              state.calendar[index].tempat),
                                    ).then((success) {
                                      scaffoldMessengerKey.currentState!
                                          .showSnackBar(SnackBar(
                                              content: Text(success
                                                  ? 'Success'
                                                  : 'Error')));
                                    });
                                  },
                                  icon: Icon(FontAwesomeIcons.calendar),
                                  label: Text('Add to Calendar'),
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xff3BBC86),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                closedBuilder: (context, openContainer) {
                  return InkWell(
                    onTap: openContainer,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.28,
                      width: MediaQuery.of(context).size.width * 0.1,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18)),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 3.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
                                child: Image.network(
                                  state.calendar[index].thumbnail,
                                  height:
                                      MediaQuery.of(context).size.height * 0.24,
                                  width:
                                      MediaQuery.of(context).size.width * 0.35,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state.calendar[index].name,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xff3BBC86),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      state.calendar[index].description.length >
                                              50
                                          ? '${state.calendar[index].description.substring(0, 50)}...'
                                          : state.calendar[index].description,
                                      style: const TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      'Tanggal/Waktu :',
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '${DateFormat.yMMMd('en_US').add_jm().format(state.calendar[index].dateStart)} ${state.calendar[index].waktuStart}',
                                      style: const TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      'Tempat :',
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '${state.calendar[index].tempat}',
                                      style: const TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            itemCount: state.calendar.length < 4 ? state.calendar.length : 3,
          );
        } else {
          return Center(
            child: Text('Error'),
          );
        }
      },
    );
  }
}
