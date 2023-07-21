import 'package:basic_navigation/utils/event.dart';
import 'package:flutter/material.dart';

class EventProvider extends ChangeNotifier{
  final List<Event> _events =[];
   String name = ''; 
  String email = '';

  DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;

  void setDate(DateTime date) => _selectedDate = date;

  List<Event> get eventsOfSelectedDate => _events;

  List <Event> get events => _events;

  void addName(String toAdd){
    name = toAdd;
    notifyListeners();
  }//addProduct

  void addEmail(String toAdd){
    email = toAdd;
    //Call the notifyListeners() method to alert that something happened.
    notifyListeners();
  }//clearCart
  
//Cart
  }
