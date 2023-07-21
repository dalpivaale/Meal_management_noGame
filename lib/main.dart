import 'package:basic_navigation/screens/calendarpage.dart';
import 'package:basic_navigation/screens/homepage.dart';
import 'package:basic_navigation/screens/profilepage.dart';
import 'package:basic_navigation/screens/infopage.dart';
import 'package:basic_navigation/screens/loginpage.dart';
import 'package:basic_navigation/screens/meals.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:basic_navigation/utils/event_provider.dart';
import 'package:basic_navigation/database/database.dart';
import 'package:basic_navigation/repositories/databaseRepository.dart';

 Future<void> main() async{
  //This is a special method that use WidgetFlutterBinding to interact with the Flutter engine.
  //This is needed when you need to interact with the native core of the app.
  //Here, we need it since when need to initialize the DB before running the app.
  WidgetsFlutterBinding.ensureInitialized();

  //This opens the database.
  final AppDatabase database =
     await  $FloorAppDatabase.databaseBuilder('app_database.db').build();

  //This creates a new DatabaseRepository from the AppDatabase instance just initialized
  final databaseRepository = DatabaseRepository(database: database);

  //Here, we run the app and we provide to the whole widget tree the instance of the DatabaseRepository.
  //That instance will be then shared through the platform and will be unique.
  runApp(ChangeNotifierProvider<DatabaseRepository>(
    
    create: (context) => databaseRepository,
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EventProvider>(
      create: (context) => EventProvider(),
      child: MaterialApp(
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData.dark().copyWith(colorScheme: ThemeData.dark().colorScheme.copyWith(primary: Colors.orange)),
        initialRoute: 'login',
        routes: {
          'login':(context) => LoginPage(),
          'home': (context) => HomePage(),
          'calendar': (context) => CalendarPage(),
          'profile':(context) => ProfilePage(),
          'meals':(context)=> MealsPage(),
          'info':(context )=> InfoPage(), //la parentesi con dentro context indica che sto passando il context alla route cui sto andando
        },
      ),
    );     
  } 
}
