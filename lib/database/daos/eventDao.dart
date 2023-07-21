import 'package:basic_navigation/database/entities/event.dart';
import 'package:floor/floor.dart';

//Here, we are saying that the following class defines a dao.

@dao
abstract class EventDao {

  //Query #1: SELECT -> this allows to obtain all the entries of the Meal table
  @Query('SELECT * FROM Event')
  Future<List<Event>> findAllEvents();

  //Query #2: INSERT -> this allows to add a Meal in the table
  @insert
  Future<void> insertEvent(Event meal);

  //Query #3: DELETE -> this allows to delete a Meal from the table
  @delete
  Future<void> deleteEvent(Event task);

  //Query #4: UPDATE -> this allows to update a Meal entry
  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateEvent(Event meal);
  
}//MealDao