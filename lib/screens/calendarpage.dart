import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:provider/provider.dart';
import 'package:basic_navigation/utils/event_data_source.dart';
import 'package:basic_navigation/database/entities/event.dart';
import 'package:basic_navigation/database/entities/level.dart';
import 'package:basic_navigation/repositories/databaseRepository.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CalendarPage extends StatefulWidget {

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  Color? col1 = Colors.grey; Color? col2 = Colors.grey; Color? col3 = Colors.grey;
  Color? col4 = Colors.grey; Color? col5 = Colors.grey; Color? col6 = Colors.grey;
  Color? col7 = Colors.grey; Color? col8 = Colors.grey; Color? col9 = Colors.grey;
  Color? col10 = Colors.grey; Color? col11 = Colors.grey;  Color? col12 = Colors.grey;
  Color? col13 = Colors.grey; Color? col14 = Colors.grey; 
  List<Color?> icone = [Colors.grey,Colors.grey,Colors.grey,Colors.grey,Colors.grey,Colors.grey,Colors.grey,Colors.grey,Colors.grey,Colors.grey,Colors.grey]  ;
  String bottone = 'Edit';
  double blurRadius = 0;
  Color? colorButton = Color.fromARGB(255, 66, 64, 64);
  @override
  void initState() {
    super.initState();
  }// This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    icone = [col1,col2,col3,col4,col5,col6,col7,col8,col9,col10,col11,col12,col13,col14];
   // _3giorni();
    return Scaffold(
      appBar: AppBar(title: Align(alignment:Alignment.center ,child: Text('Calendar')),
      leading: IconButton(icon:Icon(Icons.arrow_back),onPressed:() =>Navigator.of(context).pop()),
      ),
     body: Padding(  
      padding:EdgeInsets.all(0.1) ,
       child: Consumer<DatabaseRepository>(
          builder: (context, dbr, child) {
           return FutureBuilder(
              initialData: null,
              future: dbr.findAllEvents(),
              builder:(context, snapshot) {
          var eventi = <Event?> [];
          if (snapshot.hasData)
           eventi = snapshot.data as List<Event>;          
         
          return  SfCalendar(
            todayHighlightColor: Colors.orange,  
            view:CalendarView.month,
            dataSource: EventDataSource(eventi),
            firstDayOfWeek: 1, // Monday as 1 day of the week
            initialSelectedDate: DateTime.now(),
            appointmentTimeTextFormat:'hh:mm:ss',
            onTap:(details){
              var pastiOfselectedDay = giorno(eventi, details.date!);  //mette in pastiOfselectedDay tutti i pasti di quel giorno
                  if(pastiOfselectedDay.id == null)
              {
               const snackBar = SnackBar(content: Text('No meals found'),);
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
                else{
                _flag(pastiOfselectedDay);
                  showModalBottomSheet(
                  context: context,
                  isScrollControlled:true,
                  builder: (BuildContext context) {
                    return StatefulBuilder(builder: (context, setState){          
                             return FractionallySizedBox(
                              heightFactor: 0.8,
                               child:ListView(
                                     children:[
                                           Row(
                                             children: [
                                               Container(
                                                alignment: Alignment.topLeft,
                                                width: 140,
                                                height: 40,
                                                 child: ElevatedButton.icon(                                 
                                                       icon: Icon(Icons.arrow_back,size: 20.0,color:Colors.white),
                                                         style: ElevatedButton.styleFrom(primary: Color.fromARGB(255, 66, 64, 64),side: BorderSide.none,elevation:0),
                                                         label: Text(pastiOfselectedDay.from.toString().substring(0,11),style:TextStyle(color:Colors.white),),                                                 
                                                     onPressed: () => Navigator.pop(context)
                                                      ),
                                                 
                                               ),
                                              
                                               Spacer(),
                                               Container(
                                                alignment: Alignment.topRight,
                                                width: 70,
                                                height: 30,
                                                   child: FloatingActionButton( 
                                                   // tooltip: 'Save',  
                                                    backgroundColor: colorButton,   
                                                      elevation: 0,
                                                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),                   
                                                    child: Text(bottone,style: TextStyle(fontSize:20,color:Colors.white,),),
                                                   onPressed: () async{if(bottone=='Edit')
                                                      setState(() {bottone = 'Save'; colorButton = Color.fromARGB(255, 251, 13, 13);blurRadius = 15; });
                                                      else{
                                                       setState(() {bottone = 'Edit';colorButton= Color.fromARGB(255, 66, 64, 64);blurRadius = 0;});
                                                         _editEvents(pastiOfselectedDay);
                                                      
                                                       }}
                                                      ),
                                                 
                                               ),
                                             ],
                                           ),       
                                            Row(
                                              children:[ 
                                                Column(
                                                         mainAxisAlignment: MainAxisAlignment.center,
                                                         crossAxisAlignment: CrossAxisAlignment.center,
                                                         children:[ 
                                                               Text('Breakfast',style: TextStyle(fontSize:25,color: Colors.orangeAccent),),
                                                               SizedBox(height: 10),
                                                                      Container(
                                                                            height: 50,
                                                                             width: 180,
                                                                              child:ListTile(
                                                                              leading:IconButton(onPressed: () { if(bottone == 'Save'){if(col1 == Colors.grey){setState((){ col1 = Colors.redAccent; col2 = Colors.grey;col3 = Colors.grey;icone[1] = col2;icone[2] = col3;});icone[0] = col1;} else {setState(() => col1 = Colors.grey);icone[0] = col1;}}},
                                                                               icon: Icon(Icons.bookmark_rounded,color:col1, shadows: <Shadow>[Shadow(color: Color.fromARGB(255, 249, 17, 17), blurRadius:  blurRadius)])),
                                                                               title:Text('continental')),
                                                                                 ),                          
                                                                          Container(
                                                                              height: 50,
                                                                              width: 180,
                                                                                 child: ListTile(
                                                                              leading:IconButton(onPressed:(){ if(bottone == 'Save'){if(col2 == Colors.grey){setState(() {col2 = Colors.redAccent; col1 = Colors.grey;col3 = Colors.grey;icone[0] = col2;icone[2] = col3;});icone[1] = col2;} else {setState(() => col2 = Colors.grey);icone[1] = col2;}}},
                                                                               icon: Icon(Icons.bookmark_rounded,color:col2, shadows: <Shadow>[Shadow(color: Color.fromARGB(255, 249, 17, 17), blurRadius:  blurRadius)])),
                                                                                 title:Text('english')),
                                                                               ),
                                                                               Container(
                                                                                height: 50,
                                                                                width: 180,
                                                                                 child: ListTile(
                                                                              leading:IconButton(onPressed:(){ if(bottone == 'Save'){if(col3 == Colors.grey){setState((){col3 = Colors.redAccent; col1 = Colors.grey;col2 = Colors.grey;icone[0] = col2;icone[1] = col3;});icone[2] = col3;} else {setState(() => col3 = Colors.grey);icone[2] = col3;}}}, 
                                                                              icon: Icon(Icons.bookmark_rounded,color:col3, shadows: <Shadow>[Shadow(color: Color.fromARGB(255, 249, 17, 17), blurRadius:  blurRadius)])),
                                                                                 title:Text('american')),
                                                                               ),
                                                                            SizedBox(height: 60,),
                                                                            Text('Dinner',style: TextStyle(fontSize:25,color: Colors.orangeAccent )),
                                                                            SizedBox(height: 10),
                                                                            Container(
                                                                              height: 50,
                                                                              width: 160,
                                                                                 child:ListTile(
                                                                              leading:IconButton(onPressed:(){ if(bottone == 'Save'){if(col4 == Colors.grey){setState(() => col4 = Colors.redAccent);icone[3] = col4;} else {setState(() => col4 = Colors.grey);icone[3] = col4;}}}, 
                                                                              icon: Icon(Icons.bookmark_rounded,color:col4, shadows: <Shadow>[Shadow(color: Color.fromARGB(255, 249, 17, 17), blurRadius:  blurRadius)])),
                                                                               title:Text('first course')),
                                                                                 ),
                                                                          
                                                                          Container(
                                                                              height: 50,
                                                                              width: 160,
                                                                                 child: ListTile(
                                                                              leading:IconButton(onPressed:(){ if(bottone == 'Save'){if(col5 == Colors.grey){setState(() => col5 = Colors.redAccent);icone[4] = col5;} else {setState(() => col5 = Colors.grey);icone[4] = col5;}}},
                                                                              icon: Icon(Icons.bookmark_rounded,color:col5, shadows: <Shadow>[Shadow(color: Color.fromARGB(255, 249, 17, 17), blurRadius:  blurRadius)])),
                                                                                 title:Text('second course')),
                                                                               ),
                                                                               Container(
                                                                                height: 50,
                                                                                width: 160,
                                                                                 child: ListTile(
                                                                              leading:IconButton(onPressed:(){ if(bottone == 'Save'){if(col6 == Colors.grey){setState(() => col6 = Colors.redAccent);icone[5] = col6;} else {setState(() => col6 = Colors.grey);icone[5] = col6;}}},
                                                                               icon: Icon(Icons.bookmark_rounded,color:col6, shadows: <Shadow>[Shadow(color: Color.fromARGB(255, 249, 17, 17), blurRadius:  blurRadius)])),
                                                                                 title:Text('side dish')),
                                                                               ),
                                                                                Container(
                                                                                height: 50,
                                                                                width: 160,
                                                                                 child: ListTile(
                                                                              leading:IconButton(onPressed:(){if(bottone == 'Save'){if(col7 == Colors.grey){setState(() => col7 = Colors.redAccent);icone[6] = col7;} else {setState(() => col7 = Colors.grey);icone[6] = col7;}}},
                                                                              icon: Icon(Icons.bookmark_rounded,color:col7, shadows: <Shadow>[Shadow(color: Color.fromARGB(255, 249, 17, 17), blurRadius:  blurRadius)])),
                                                                                 title:Text('dessert')),
                                                                               )]
                                                                     ),                                                            
                                                                                                         
                                                             SizedBox(width: 20),
                                                              Column(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                children:[
                                                                  Text('Lunch',style: TextStyle(fontSize:25,color: Colors.orangeAccent )),
                                                                  SizedBox(height: 10),
                                                                   Container(
                                                                      height: 50,
                                                                      width: 160,
                                                                         child:ListTile(
                                                                      leading:IconButton(onPressed:(){ if(bottone == 'Save'){if(col8 == Colors.grey){setState(() => col8 = Colors.redAccent);icone[7] = col8;} else {setState(() => col8 = Colors.grey);icone[7] = col8;}}},
                                                                       icon: Icon(Icons.bookmark_rounded,color:col8, shadows: <Shadow>[Shadow(color: Color.fromARGB(255, 249, 17, 17), blurRadius:  blurRadius)])),
                                                                       title:Text('first course')),
                                                                         ),
                                                                  
                                                                  Container(
                                                                      height: 50,
                                                                      width: 160,
                                                                         child: ListTile(
                                                                      leading:IconButton(onPressed:(){ if(bottone == 'Save'){if(col9 == Colors.grey){setState(() => col9 = Colors.redAccent);icone[8] = col9;} else {setState(() => col9 = Colors.grey);icone[8] = col9;}}},
                                                                       icon: Icon(Icons.bookmark_rounded,color:col9, shadows: <Shadow>[Shadow(color: Color.fromARGB(255, 249, 17, 17), blurRadius:  blurRadius)])),
                                                                         title:Text('second course')),
                                                                       ),
                                                                       Container(
                                                                        height: 50,
                                                                        width: 160,
                                                                         child: ListTile(
                                                                      leading:IconButton(onPressed:(){if(bottone == 'Save') {if(col10 == Colors.grey){setState(() => col10 = Colors.redAccent);icone[9] = col10;} else {setState(() => col10 = Colors.grey);icone[9] = col10;}}},
                                                                       icon: Icon(Icons.bookmark_rounded,color:col10, shadows: <Shadow>[Shadow(color: Color.fromARGB(255, 249, 17, 17), blurRadius:  blurRadius)])),
                                                                         title:Text('side dish')),
                                                                       ),
                                                                       Container(
                                                                        height: 50,
                                                                        width: 160,
                                                                         child: ListTile(
                                                                      leading:IconButton(onPressed:(){if(bottone == 'Save'){if(col11 == Colors.grey){setState(() => col11 = Colors.redAccent);icone[10] = col11;} else {setState(() => col11 = Colors.grey);icone[10] = col11;}}}, 
                                                                      icon: Icon(Icons.bookmark_rounded,color:col11, shadows: <Shadow>[Shadow(color: Color.fromARGB(255, 249, 17, 17), blurRadius:  blurRadius)])),
                                                                         title:Text('dessert')),
                                                                       ),
                                                                    SizedBox(height: 10),
                                                                    Text('Snack',style: TextStyle(fontSize:25,color: Colors.orangeAccent )),
                                                                    SizedBox(height: 10),
                                                                    Container(
                                                                      height: 50,
                                                                      width: 160,
                                                                         child:ListTile(
                                                                      leading:IconButton( onPressed: () { if(bottone == 'Save'){ if(col12 == Colors.grey){setState(() {col12 = Colors.redAccent; col13 = Colors.grey;col14 = Colors.grey;icone[12] = col13;icone[13] = col14;});icone[11] = col12;} else {setState(() => col12 = Colors.grey);icone[11] = col12;}}},
                                                                               icon: Icon(Icons.bookmark_rounded,color:col12, shadows: <Shadow>[Shadow(color: Color.fromARGB(255, 249, 17, 17), blurRadius:  blurRadius)])),
                                                                       title:Text('small')),
                                                                         ),
                                                                  
                                                                  Container(
                                                                      height: 50,
                                                                      width: 160,
                                                                         child: ListTile(
                                                                      leading:IconButton(onPressed: () { if(bottone == 'Save'){if(col13 == Colors.grey){setState((){ col13 = Colors.redAccent; col12 = Colors.grey;col14 = Colors.grey;icone[11] = col12;icone[13] = col14;});icone[12] = col13;} else {setState(() => col13 = Colors.grey);icone[12] = col13;}}},
                                                                               icon: Icon(Icons.bookmark_rounded,color:col13, shadows: <Shadow>[Shadow(color: Color.fromARGB(255, 249, 17, 17), blurRadius:  blurRadius)])),
                                                                         title:Text('medium')),
                                                                       ),
                                                                       Container(
                                                                        height: 50,
                                                                        width: 160,
                                                                         child: ListTile(
                                                                      leading:IconButton(onPressed: () { if(bottone == 'Save'){if(col14 == Colors.grey){setState((){ col14 = Colors.redAccent; col13 = Colors.grey;col12 = Colors.grey;icone[11] = col12;icone[12] = col13;});icone[13] = col14;} else {setState(() => col14 = Colors.grey);icone[13] = col14;}}},
                                                                               icon: Icon(Icons.bookmark_rounded,color:col14, shadows: <Shadow>[Shadow(color: Color.fromARGB(255, 249, 17, 17), blurRadius:  blurRadius)])),
                                                                         title:Text('large')),
                                                                       ),
                                                                           SizedBox(height:50),                       ]
                                                                                               ),
                                                                                                             ],
                                                              
                                            ),
                                                SizedBox(height:15),                           
                                                Container(
                                                alignment: Alignment.bottomCenter,
                                                width: 140,
                                                height: 40,
                                                 child: Consumer<DatabaseRepository>(
                                                builder: (context, dbr, child) {                                                        
                                                       return ElevatedButton.icon( 
                                                       icon: Icon(Icons.cancel_presentation_rounded, color: Colors.white,),
                                                         style: ElevatedButton.styleFrom(primary: Color.fromARGB(255, 66, 64, 64),side: BorderSide.none,  elevation: 0,),
                                                         label: Text('Remove meals',style:TextStyle(color:Colors.redAccent,fontSize: 15),),                                            
                                                    onPressed: () async{ 
                                                                   await  Provider.of<DatabaseRepository>(context, listen: false).removeEvent(pastiOfselectedDay);                                                                                                                                                                                                 
                                                                 Navigator.pop(context);                                                                 
                                                                }                                                      
                                                            );
                                                } 
                                                 )
                                                )] 
                                                   
                                                          ),
                                                  );                                               
                                          }); 
                                     },                                  
                                  );
                               }
                             },                
                          );
                     }
                  );
                }
            )
     ),
    floatingActionButton: FloatingActionButton(onPressed:( ) => Navigator.pushNamed(context, 'meals'),
       child: Icon(Icons.add,color: Colors.white,size: 35,),backgroundColor: Colors.red,)
   ); 
  }

   _flag(Event pastiOfselectedDay){ //una volta caricato il pasto nella meal page _flag colora le icone di rosso o grigio a seconda..
   col1 = Colors.grey; col2 = Colors.grey; col3 = Colors.grey; col4 = Colors.grey;  col5 = Colors.grey;
   col6 = Colors.grey;col7 = Colors.grey;col8 = Colors.grey;col9 = Colors.grey; col10 = Colors.grey;
   col11 = Colors.grey; col12 = Colors.grey; col13 = Colors.grey;col14 = Colors.grey;

      if( pastiOfselectedDay.colazione == 'continental'){  
        setState(() => col1 = Colors.redAccent);}         

       if( pastiOfselectedDay.colazione == 'english'){  
        setState(() => col2 = Colors.redAccent);}    

       if( pastiOfselectedDay.colazione == 'american'){  
        setState(() => col3 = Colors.redAccent);}        

      if( pastiOfselectedDay.cena1 == 'first course'){  
        setState(() => col4 = Colors.redAccent); }       

       if( pastiOfselectedDay.cena2=='second course') { 
        setState(() => col5 = Colors.redAccent); }       

       if( pastiOfselectedDay.cena3=='side dish'){  
        setState(() => col6 = Colors.redAccent);}        

       if( pastiOfselectedDay.cena4=='dessert'){  
        setState(() => col7 = Colors.redAccent);}        

      if( pastiOfselectedDay.pranzo1 == 'first course'){  
        setState(() => col8 = Colors.redAccent);}        

       if( pastiOfselectedDay.pranzo2 == 'second course'){  
        setState(() => col9 = Colors.redAccent);}        

       if( pastiOfselectedDay.pranzo3 == 'side dish'){  
        setState(() => col10 = Colors.redAccent);  }      

       if(pastiOfselectedDay.pranzo4 == 'dessert') { 
        setState(() => col11 = Colors.redAccent); }   

        if( pastiOfselectedDay.snack == '   small  '){  
        setState(() => col12 = Colors.redAccent);}        

       if( pastiOfselectedDay.snack == '   medium  '){  
        setState(() => col13 = Colors.redAccent);}        

       if( pastiOfselectedDay.snack == '   large  '  ){  
        setState(() => col14 =Colors.redAccent);  }              
    
    //edit di un evento e lo aggiorna
}
 Event giorno(List<Event?> eventi,DateTime giorno){//restituisce tutti i pasti di quel giorno
    var pastiOfselectedDay = Event (null,'','','','','','','','','','',giorno);//lista dei pasti di quel giorno

    for(int i = 0; i < eventi.length;i++){
     if( giorno == eventi[i]!.from){ //se esiste già un giorno con dei pasti ce ne aggiunge altri
      pastiOfselectedDay = eventi[i] as Event;   
      }
    }
    return  pastiOfselectedDay;
   }

void  _editEvents (Event pastiOfselectedDay) async{ //edita l'evento e lo aggiorna
         
        var evento = Event (pastiOfselectedDay.id,'','','','','','','','','','',pastiOfselectedDay.from);

         if(icone[0] == Colors.redAccent)
            evento.colazione = 'continental';

          if(icone[1] == Colors.redAccent)
            evento.colazione = 'english';

          if(icone[2] == Colors.redAccent)
            evento.colazione ='american';

          if(icone[3] == Colors.redAccent)
            evento.cena1 = 'first course';

          if(icone[4] == Colors.redAccent)
            evento.cena2 ='second course';

              if(icone[5] == Colors.redAccent)
            evento.cena3 = 'side dish';

                if(icone[6] == Colors.redAccent)
            evento.cena4 ='dessert';
            
          if(icone[7] == Colors.redAccent)
            evento.pranzo1 = 'first course';

          if(icone[8] == Colors.redAccent)
            evento.pranzo2 = 'second course';

          if(icone[9] == Colors.redAccent)
            evento.pranzo3 = 'side dish';

          if(icone[10] == Colors.redAccent)
            evento.pranzo4 = 'dessert';

          if(icone[11] == Colors.redAccent)
            evento.snack = '   small  ';

          if(icone[12] == Colors.redAccent)
            evento.snack = '   medium  ';

          if(icone[13] == Colors.redAccent)
            evento.snack = '   large  ';          
  
       await Provider.of<DatabaseRepository>(context,listen: false).updateMeal(evento);
     } 

Widget monthCellBuilder(BuildContext context, MonthCellDetails details){
  if(details.appointments.isNotEmpty){
  return   
        Column(
                children: [
       Container(
       // color: details.date.toString().substring(0,10) == DateTime.now().toString().substring(0,10) ? Colors.orange : null ,
         child: Text(details.date.day.toString(),
             textAlign:TextAlign.center),
       ),
                  
              //SizedBox(height: 63,),
               Align(alignment: Alignment.bottomCenter,
               heightFactor:12,
                 child: Container(
                        height: 5,
                        width:5,
                        color:Colors.orange
                      ),
               )
                ],
              );    
}
return
Container(
      child: Text(details.date.day.toString(),
      textAlign:TextAlign.center),
    );
}
}