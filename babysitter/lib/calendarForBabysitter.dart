import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart'; // Pour les formats de date
import 'package:http/http.dart' as http;

class CalendrierRendezVousPage extends StatefulWidget {
  final String babysitterName;

  CalendrierRendezVousPage({required this.babysitterName});
  @override
  _CalendrierRendezVousPageState createState() =>
      _CalendrierRendezVousPageState();
}

Map<String, dynamic>? parent = GetStorage().read('parent');

class _CalendrierRendezVousPageState extends State<CalendrierRendezVousPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay =
      DateTime.now(); // Initialise _selectedDay à la date actuelle

  TimeOfDay _selectedTime = TimeOfDay.now();

  void _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }
  void _sendRendezVous() async {
    try {
      print(widget.babysitterName);
      print(parent!['id']);
      final String apiUrl =
          'http://192.168.1.17:3000/api/parents/${parent!['id']}/${widget.babysitterName}/rendezvous';

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, dynamic>{
          'date': _selectedDay.toIso8601String(), // Envoyer la date
          'heure':
              '${_selectedTime.hour}:${_selectedTime.minute}', // Envoyer l'heure au format HH:mm
          'nomParent': parent!['nom'],
        }),
      );

      if (response.statusCode == 201) {
        print("mriiigl");
      } else {
        print("${response.body}");
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendrier des rendez-vous'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TableCalendar(
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
            ),
            SizedBox(height: 20),
            Center(
              child: TextButton(
                onPressed: () => _selectTime(context),
                child: Text('Choisir l\'heure du rendez-vous'),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () => _sendRendezVous(),
                child: Text('Envoyer le rendez-vous'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
