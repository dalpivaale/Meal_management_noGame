import 'package:flutter/material.dart';
class InfoPage extends StatefulWidget{
    const InfoPage({Key? key}) : super(key: key);
  @override 
  InfoPageState createState() => InfoPageState();
}

class InfoPageState extends State<InfoPage>{
@override 
  Widget build(BuildContext context) => Scaffold(
    body: 
      ListView( scrollDirection : Axis.vertical,
        children:[
                     Align(alignment: Alignment.topLeft,child: FloatingActionButton(onPressed:()=> Navigator.pop(context),child: Icon(Icons.arrow_back,color:Colors.white,size: 40),elevation: 0,backgroundColor: Color.fromARGB(0, 253, 6, 6),)),
         Align(alignment: Alignment.center,child: Text("IN ITALIANO " + '\n',style:TextStyle(fontSize: 15))),
        Container(   margin: EdgeInsets.all(5), padding: EdgeInsets.all(5),
          child: Text(
                "Quest' app consente di tener traccia dei pasti che l'utente consuma giornalmente.\n Cliccando il bottone + si accede alla pagina dei pasti selezionabili, una volta scelti "
                + "saranno inseriti in un caledario. Si ottiene così un diario di ciò che si ha consumato giorno per giorno.",
                style:TextStyle(fontSize: 15)),
        ),      //INGLESE
        Align(alignment: Alignment.center,child: Text("IN ENGLISH " + '\n',style:TextStyle(fontSize: 15))),
        Container(   margin: EdgeInsets.all(5), padding: EdgeInsets.all(5),
          child: Text(
    "This app allows you to track the meals you consume on a daily basis. Clicking the + button you access the page of selectable meals which, once chosen "
                + "they will be entered in a calendar. So you obtain a diary of what has been consumed day by day.",style:TextStyle(fontSize: 15)),
        ),
      ],)
    
  );
}