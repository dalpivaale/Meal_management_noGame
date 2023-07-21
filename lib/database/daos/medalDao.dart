import 'package:basic_navigation/database/entities/medal.dart';
import 'package:floor/floor.dart';

//Here, we are saying that the following class defines a dao.

@dao
abstract class MedalDao {

  //Query #1: SELECT -> this allows to obtain all the entries of the Meal table
  @Query('SELECT * FROM Medal')
  Future<List<Medal>> findAllMedals();

  //Query #2: INSERT -> this allows to add a Meal in the table
  @insert
  Future<void> insertMedals(Medal medaglie);

  //Query #3: DELETE -> this allows to delete a Meal from the table
  @delete
  Future<void> deleteMedals(Medal medaglie);

  //Query #4: UPDATE -> this allows to update a Meal entry
  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateMedals(Medal medaglie);  
}//LevelDao