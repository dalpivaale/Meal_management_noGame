import 'package:basic_navigation/database/entities/medal.dart';
import 'package:basic_navigation/widget/snack_buttons_widget.dart';
import 'package:flutter/material.dart';
import 'package:basic_navigation/widget/breakfast_buttons_widget.dart';
import 'package:basic_navigation/widget/lunch_buttons_widget.dart';
import 'package:basic_navigation/widget/formTiles.dart';
import 'package:basic_navigation/widget/dinner_buttons_widget.dart';
import 'package:basic_navigation/widget/formats.dart';
import 'package:provider/provider.dart';
import 'package:basic_navigation/database/entities/event.dart';
import 'package:basic_navigation/database/entities/level.dart';
import 'package:basic_navigation/repositories/databaseRepository.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MealsPage extends StatefulWidget {
  @override
  State<MealsPage> createState() => _MealsPageState();
}

class _MealsPageState extends State<MealsPage> {
    List<String?> pranzo= [];
    List<String?> cena = [];
    List<Event> eventi =  [];
    String colazione = '';  
    String snack = '';
    var pastiOfselectedDay = Event (null,'','','','','','','','','','',DateTime.now());//lista dei pasti di quel giorno
   DateTime _selectedDate = DateTime.now();
   Map map1 = {'pranzo0': '','pranzo1':'','pranzo2': '','pranzo3':''};
  Map map2 = {'cena0':'','cena1':'','cena2': '','cena3':''};

@override
  void initState() {
   _setMeals(DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day,0,0,0,0));
    super.initState();
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
  _selectedDate = DateTime( _selectedDate.year, _selectedDate.month,_selectedDate.day,  0,  0,  0,  0);
    return Scaffold(
      backgroundColor:Colors.black,
      appBar: AppBar(title: Align(alignment:Alignment.center ,child: Text('    Meals')),backgroundColor:Color.fromARGB(255, 66, 64, 64),
        actions: <Widget>[
          Row(
            children: [
              Text('SAVE'),
               IconButton(
            icon: const Icon(Icons.done),
            iconSize: 40,
            tooltip: 'Save meals',
            onPressed: () => addEvento(context)) 
            ],
          ),
         
        ]),  

      body:Padding(
       padding: const EdgeInsets.all(1.0),
       child: Consumer<DatabaseRepository>(
          builder: (context, dbr, child) {
           return FutureBuilder(
              initialData: null,
              future:dbr.findAllEvents(),
              builder:(context, snapshot) {                
              if(snapshot.hasData)
                 eventi = snapshot.data as List<Event>;   

        return ListView(scrollDirection:Axis.vertical,
              children: [ 
                SizedBox(height: 15),
           
            FormDateTile(
                      labelText: 'Meal Time',
                      date: _selectedDate,
                      //icon: MdiIcons.clockTimeFourOutline,
                      onPressed: () async{
                         
                         pastiOfselectedDay = Event (null,'','','','','','','','','','',_selectedDate);             
                    
                       await _selectDate(context);
                        _setMeals(_selectedDate);
                        pastiOfselectedDay.from = _selectedDate;
                      },
                      dateFormat: Formats.onlyDayDateFormat,
                    ),
                          
                   SizedBox(height: 20),
      
                  PetsButtonsWidgetB(
                    pets: colazione,
                    onSelectedPet: (pet) => setState(
                    (){ 
                        if(colazione != pet)
                        colazione = pet;
                        
                        else
                          colazione = '';                     //
                         })
                 ),
      
                  SizedBox(height: 20),
                 // Text('Lunch',style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold, fontSize: 15)),
                   PetsButtonsWidgetL(
                  pets: pranzo,
                  onSelectedPet: (pet) => setState(
                  (){ 
                      if(pranzo.contains(pet) == false){                      
                       pranzo.add(pet);
                      }
                       else{
                        pranzo.remove(pet);
                        }                      //
                       }
                       ),
                 ),
      
                  SizedBox(height: 20),
                  
                  PetsButtonsWidgetD(
                  pets: cena,
                  onSelectedPet: (pet) => setState(
                  (){ 
                      if(cena.contains(pet) == false){                      
                       cena.add(pet);
                      }
                       else{
                        cena.remove(pet);
                       }                        //
                       }
                       ),
                 ),

                     SizedBox(height: 20),
                 // Text('Lunch',style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold, fontSize: 15)),
                  PetsButtonsWidgetS(
                    pets: snack,
                    onSelectedPet: (pet) => setState(
                    (){ 
                        if(snack != pet)
                          snack = pet;
                        
                        else
                          snack = '';                     //
                         })
                 ),  
                // ElevatedButton(onPressed:(() => addEvento(context,ciccio)), child:(Text('Save'))),   
          
              ],
          );
              }
           );
          }
       )
      )
      );     
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
            context: context,
            initialDate:_selectedDate,
            initialDatePickerMode: DatePickerMode.day,
            firstDate: DateTime(2010),
            lastDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day));
     
    if (picked != null && picked != _selectedDate){
      setState(() {
        _selectedDate = picked;
      });
    }
  }
    void addEvento(BuildContext context)async{ 
   if(pranzo.contains('first course'))
      map1['pranzo0'] = 'first course';
   
   if(pranzo.contains('second course'))
      map1['pranzo1'] = 'second course';

   if(pranzo.contains('side dish'))
      map1['pranzo2'] = 'side dish';
   
   if(pranzo.contains('dessert'))
      map1['pranzo3'] = 'dessert';

   if(cena.contains('first course'))
      map2['cena0'] = 'first course';
   
   if(cena.contains('second course'))
      map2['cena1'] = 'second course';

   if(cena.contains('side dish'))
      map2['cena2'] = 'side dish';
   
   if(cena.contains('dessert'))
      map2['cena3'] = 'dessert';

  if(colazione == '' &&  map1['pranzo0']==''&& map1['pranzo1']==''&& map1['pranzo2']==''&& map1['pranzo3']==''&& map2['cena0']==''&& map2['cena1']==''&& map2['cena2']==''&& map2['cena3']==''&& snack=='')
      Navigator.pop(context); //se non clicca neanche un pasto e poi fa SAVE non devo caricare niente al calendario
else{
  if(pastiOfselectedDay.id == null){
     Event newEvent = Event(null,map1['pranzo0'],map1['pranzo1'],map1['pranzo2'],map1['pranzo3'],map2['cena0'],map2['cena1'],map2['cena2'],map2['cena3'],snack,colazione,_selectedDate);
     await Provider.of<DatabaseRepository>(context, listen: false).insertEvent(newEvent);}  
    else{
      Event updateEvent = Event(pastiOfselectedDay.id,map1['pranzo0'],map1['pranzo1'],map1['pranzo2'],map1['pranzo3'],map2['cena0'],map2['cena1'],map2['cena2'],map2['cena3'],snack,colazione,_selectedDate);
           await Provider.of<DatabaseRepository>(context, listen: false).updateMeal(updateEvent);
    }

       Navigator.pop(context);
    }//else
 }
 
_setMeals(DateTime giorno) async{
    eventi = await Provider.of<DatabaseRepository>(context, listen: false).findAllEvents();
    for(int i = 0; i < eventi.length;i++){
     if( giorno == eventi[i].from){ //se esiste già un giorno con dei pasti ce ne aggiunge altri
      pastiOfselectedDay = eventi[i] as Event;   
      }
    }  
      //HO TOLTO UN IF QUA, quello se pastiof selected day.id è diverso nal null
         colazione = pastiOfselectedDay.colazione; 
       pranzo =[pastiOfselectedDay.pranzo1,pastiOfselectedDay.pranzo2, pastiOfselectedDay.pranzo3,pastiOfselectedDay.pranzo4];
      cena = [pastiOfselectedDay.cena1, pastiOfselectedDay.cena2,pastiOfselectedDay.cena3,pastiOfselectedDay.cena4];
      snack = pastiOfselectedDay.snack;
}
}




