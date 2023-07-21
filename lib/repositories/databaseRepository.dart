import 'package:basic_navigation/database/database.dart';
import 'package:basic_navigation/database/entities/event.dart';
import 'package:basic_navigation/database/entities/level.dart';
import 'package:basic_navigation/database/entities/medal.dart';
import 'package:flutter/material.dart';

class DatabaseRepository extends ChangeNotifier{

  //The state of the database is just the AppDatabase
  final AppDatabase database;

  //Default constructor
  DatabaseRepository({required this.database});

  //This method wraps the findAllMeals() method of the DAO
  Future<List<Event>> findAllEvents() async{
    final results = await database.eventDao.findAllEvents();
    return results;
  }//findAllMeals

  //This method wraps the insertMeal() method of the DAO. 
  //Then, it notifies the listeners that something changed.
  Future<void> insertEvent(Event meal)async {
    await database.eventDao.insertEvent(meal);
    notifyListeners();
  }//insertMeal

  //This method wraps the deleteMeal() method of the DAO. 
  //Then, it notifies the listeners that something changed.
  Future<void> removeEvent(Event meal) async{
    await database.eventDao.deleteEvent(meal);
    notifyListeners();
  }//removeMeal
  
  Future<void> updateMeal(Event meal) async{
    await database.eventDao.updateEvent(meal);
    notifyListeners();
  }//updateMeal
 
 //---- LIVELLI
  Future<List<Level>> findAllLevels() async{
    final results = await database.levelDao.findAllLevels();
    return results;
  }//findAllMeals

  Future<void> insertLevel(Level livello)async {
    await database.levelDao.insertLevel(livello);
    notifyListeners();
  }

  Future<void> removeLevel(Level livello) async{
    await database.levelDao.deleteLevel(livello);
    notifyListeners();
  }
  
  Future<void> updateLevel(Level livello) async{
    await database.levelDao.updateLevel(livello);
    notifyListeners();
  }

  //-------MEDAGLIE
  
   Future<List<Medal>> findAllMedals() async{
    final results = await database.medalDao.findAllMedals();
    return results;
  }

  Future<void> insertMedals(Medal medaglie)async {
    await database.medalDao.insertMedals(medaglie);
    notifyListeners();
  }

  Future<void> removeMedals(Medal medaglie) async{
    await database.medalDao.deleteMedals(medaglie);
    notifyListeners();
  }

  Future<void> updateMedals(Medal medaglie) async{
    await database.medalDao.updateMedals(medaglie);
    notifyListeners();
  }//updateMeal

}//DatabaseRepository