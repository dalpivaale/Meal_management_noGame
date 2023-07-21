import 'package:basic_navigation/database/entities/event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:basic_navigation/utils/event_provider.dart';
class ProfilePage extends StatefulWidget{
    const ProfilePage({Key? key}) : super(key: key);
  @override 
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage>{
   @override
  void initState() {
    super.initState();
        getValue();
  } 
   @override
  void dispose() {
    tec1.dispose();
    super.dispose();
  } 
   getValue()async{
        prefs = await SharedPreferences.getInstance();
      setState(() {         
           name = prefs!.containsKey("name")? prefs!.getString("name"):""; 
           surname = prefs!.containsKey("surname")? prefs!.getString("surname"):"";
           gender = prefs!.containsKey("gender")? prefs!.getString("gender"):""; 
           age = prefs!.containsKey("age")? prefs!.getString("age"):"";
      });
        tec1.text = name as String;
        tec2.text = surname as String;
         tec3.text = gender as String;
        tec4.text = age as String;
  }
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  TextEditingController tec1 = TextEditingController();
   TextEditingController tec2 = TextEditingController();
   TextEditingController tec3 = TextEditingController();
   TextEditingController tec4 = TextEditingController();

  SharedPreferences? prefs; 
  String? name = '';
  String? surname = '';
  String? gender = '';
  String? age = '';  

  void setValue(String valore) async{
 final prefs = await SharedPreferences.getInstance();
   prefs.setString("name", valore);

  }

  @override 
  Widget build(BuildContext context) => Scaffold(
       backgroundColor: Color.fromARGB(255, 66, 64, 64),
      body:
           SingleChildScrollView(scrollDirection : Axis.vertical,
             child: Column(
              children: [ 
                Stack(
                          alignment: Alignment.center, 
                           clipBehavior: Clip.none,
                          children:[ 
                Positioned(
                  child: Container(
                      height: MediaQuery.of(context).size.height/3,
                      width: double.infinity ,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(begin: Alignment.topLeft,
                        end: Alignment.bottomRight,colors: [Color.fromARGB(255, 245, 4, 4),Color.fromARGB(255, 244, 252, 4)]),
                         borderRadius: BorderRadius.only(
                       // topLeft : Radius.circular(40),
                        bottomLeft: Radius.circular(60),
                        bottomRight: Radius.circular(60)),
                       boxShadow:   [BoxShadow(
                                      color: Colors.red,
                                      offset: Offset(10, 10),
                                       blurRadius: 10, ),]),                    
                      child:   Column(
                        children: [
                        //  SizedBox(height:10),
                            Align(alignment: Alignment.centerLeft,child: FloatingActionButton(onPressed:()=> Navigator.pop(context),child: Icon(Icons.arrow_back,color:Colors.white,size: 50),backgroundColor: Colors.transparent,elevation: 0,)),
                          Align(
                                alignment: Alignment.topCenter,
                                child:  Text((name as String) + ' ' + (surname as String) ,style:GoogleFonts.cabin(fontSize: 30,color: Colors.white,fontWeight:FontWeight.bold )),
                              ),
                        ],
                      ),
                      ),
                ),
               Positioned(
                top: 80,
                 child: Container(child:  Icon(Icons.account_circle_rounded,size:140,color: Color.fromARGB(255, 248, 249, 250),),width:MediaQuery.of(context).size.height/4,
                  height: MediaQuery.of(context).size.height/3,decoration: BoxDecoration(shape:BoxShape.circle,gradient: LinearGradient(begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,colors: [Color.fromARGB(255, 249, 3, 3),Color.fromARGB(255, 249, 151, 3)]),/*borderRadius: BorderRadius.circular(12)*/),),
               ),
                          ]),
              SizedBox(height: MediaQuery.of(context).size.height/13),
              Container(
                height: 400,
                alignment: Alignment.topCenter,
                width: 400,
                  child: ListView(
                            padding: EdgeInsets.all(10),
                            children: [
                             // Text(SavedText as String),
                     TextFormField(
                          // The validator receives the text that the user has entered.
                          controller: tec1,
                          decoration: InputDecoration(
                           border: OutlineInputBorder(),
                          hintText: 'Name',                    
                             ),
                          //initialValue: '',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),                      
                  SizedBox(height: MediaQuery.of(context).size.height/40),
                     TextFormField(
                    // The validator receives the text that the user has entered.
                    controller: tec2,
                     decoration: InputDecoration(
                       border: OutlineInputBorder(),
                      hintText: ' Surname',
                         ),
               
                              ),
                              SizedBox(height:MediaQuery.of(context).size.height/40),
                              TextFormField(
                    // The validator receives the text that the user has entered.
                    controller: tec3,
                     decoration: InputDecoration(
                       border: OutlineInputBorder(),
                      hintText: ' gender',
                         ),
                  
                              ),
                              SizedBox(height:MediaQuery.of(context).size.height/40),
                              TextFormField(
                    // The validator receives the text that the user has entered.
                    controller: tec4,
                     decoration: InputDecoration(
                       border: OutlineInputBorder(),
                      hintText: 'age',
                         ),
                
                              ),
                              SizedBox(height:MediaQuery.of(context).size.height/40),
                  
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                      minimumSize: Size(70, 50),
                      primary: Colors.orange,),
                        onPressed: () {
                          setState(() {
                                 name = tec1.text;
                                 surname = tec2.text;
                                 gender = tec3.text;
                                 age = tec4.text;
                          });
                         // setValue(tec1.text);
                         prefs!.setString("name", tec1.text);
                           prefs!.setString("surname", tec2.text);
                            prefs!.setString("gender", tec3.text);
                           prefs!.setString("age", tec4.text);
                         //   Provider.of<EventProvider>(context, listen: false).addName(tec1.text);
                           //  Provider.of<EventProvider>(context, listen: false).addEmail(tec3.text);
                        },
                        child: const Text('Save'),
                      ),           
                            ],
                          ),
                
              ),
                     ]),
           )
        
  );
}

 