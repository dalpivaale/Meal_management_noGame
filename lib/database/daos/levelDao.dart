import 'package:basic_navigation/database/entities/level.dart';
import 'package:floor/floor.dart';

//Here, we are saying that the following class defines a dao.

@dao
abstract class LevelDao {

  //Query #1: SELECT -> this allows to obtain all the entries of the Meal table
  @Query('SELECT * FROM Level')
  Future<List<Level>> findAllLevels();

  //Query #2: INSERT -> this allows to add a Meal in the table
  @insert
  Future<void> insertLevel(Level livello);

  //Query #3: DELETE -> this allows to delete a Meal from the table
  @delete
  Future<void> deleteLevel(Level livello);

  //Query #4: UPDATE -> this allows to update a Meal entry
  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateLevel(Level livello);  
}//LevelDao