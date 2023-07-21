
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:basic_navigation/database/entities/event.dart';

class EventDataSource extends CalendarDataSource{
  EventDataSource(List<Event?> appointments){
    this.appointments = appointments;    
  }

  Event getEvent(int index) => appointments![index] as Event;

  @override 
  DateTime getStartTime(int index) => getEvent(index).from; //momento di inizio dell'evento, ci assegno la proprità from dell'evento

  @override 
  DateTime getEndTime(int index) => getEvent(index).from.add(Duration(seconds: 3)); //aggiungo una durata all'appuntamento, ciò è necessario altrimenti sf calendar mette i punti ai giorni antecedenti a DateTimen.now
}