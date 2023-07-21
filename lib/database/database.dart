//Imports that are necessary to the code generator of floor
import 'dart:async';
import 'package:basic_navigation/database/daos/levelDao.dart';
import 'package:basic_navigation/database/entities/level.dart';
import 'package:basic_navigation/database/daos/eventDao.dart';
import 'package:basic_navigation/database/daos/medalDao.dart';
import 'package:basic_navigation/database/entities/event.dart';
import 'package:basic_navigation/database/entities/medal.dart';
import 'package:floor/floor.dart';
import 'package:basic_navigation/database/typeConverters/dateTimeConverter.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

 //The generated code will be in database.g.dart
 part 'database.g.dart';

//Here we are saying that this is the first version of the Database and it has just 1 entity, i.e., Meal.
//We also added a TypeConverter to manage the DateTime of a Meal entry, since DateTimes are not natively
//supported by Floor.
@TypeConverters([DateTimeConverter])
@Database(version: 1, entities: [Event,Level,Medal])
abstract class AppDatabase extends FloorDatabase {
  //Add all the daos as getters here
  EventDao get eventDao;
  LevelDao get levelDao;
  MedalDao get medalDao;
}//AppDatabase
