import 'package:basic_navigation/utils/download.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:basic_navigation/database/entities/level.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:basic_navigation/repositories/databaseRepository.dart';
import 'package:intl/intl.dart';
import 'package:basic_navigation/utils/event_provider.dart';

class HomePage extends StatefulWidget{
    const HomePage({Key? key}) : super(key: key);
  @override 
  HomePageState createState() => HomePageState();

}

class HomePageState extends State<HomePage> {
  Level level = Level(null,0,0,1); 
  String nome = '';
  String Email = '';
  //final DateFormat dateFormat =DateFormat('EEEE').format(DateTime.now());

     @override
  void initState(){
    super.initState();
  }

  @override 
  Widget build(BuildContext context) {

    return Scaffold( backgroundColor: Colors.black,
      appBar: PreferredSize(preferredSize: Size.fromHeight(35),
        child: AppBar(title: Align(alignment:Alignment.center ,child: Text('Home')),
          elevation: 0,
           backgroundColor: Color.fromARGB(255, 66, 64, 64)),
      ),
      
         drawer: Drawer(
          child: ListView(
          padding: EdgeInsets.zero,
          children: [
           DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 66, 64, 64),
              ),
                child: Column(
                  children: [
                    Container(child:  Icon(Icons.account_circle_rounded,size:60,color: Color.fromARGB(255, 248, 249, 250),),width:320,
                      height: 100,decoration: BoxDecoration(shape:BoxShape.circle,gradient: LinearGradient(begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,colors: [Color.fromARGB(255, 249, 3, 3),Color.fromARGB(255, 249, 151, 3)]),/*borderRadius: BorderRadius.circular(12)*/),),
                        SizedBox(height:10),
                      
                  FutureBuilder(
                future: _getUsername(),
                 builder: (context, child){
                      return   Text(Email,style:TextStyle(fontSize:20));})
                  ],
                ),
             
            ),
            Container(margin: EdgeInsets.all(5), padding: EdgeInsets.all(10),height:MediaQuery.of(context).size.height/11,
              child: ElevatedButton(onPressed:() async{DownloadDb downloader = DownloadDb(db: Provider.of<DatabaseRepository>(context, listen: false).database);
              bool done = await downloader.downloadData();const snackBar = SnackBar(content: Text('Meals saved in your phone'),duration: Duration(seconds:5),);
                ScaffoldMessenger.of(context).showSnackBar(snackBar); Navigator.pop(context);},
                 child: Text('Download data',style:TextStyle(fontSize: 16)), /*style: ElevatedButton.styleFrom(padding:EdgeInsets.all(10))*/),
            ),
         
            ListTile(
              leading: Icon(Icons.account_box_rounded),
              title: Text('Profile'),
              onTap: () => Navigator.pushNamed(context, 'profile')
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('Info'),
              onTap: () =>Navigator.pushNamed(context, 'info')
            ),
              ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () => _toLoginPage(context),
            ),
          ],
        ),
      ),
      body:
      Column(
        children: [
            SizedBox(height:10),
            FutureBuilder(
                future: _getName(),
                 builder: (context, child) {                             
                          return Align(alignment: Alignment.centerLeft,child: Text('Hello  '+nome +'!',style: TextStyle(fontSize: 20, color: Colors.white,fontWeight:FontWeight.bold)));
                 }
                ),
                 SizedBox(height:5),
                      Stack(
                        alignment: Alignment.center, 
                         clipBehavior: Clip.none,
                       // fit: StackFit.passthrough, 
                        children:[ 
                  Container(
                      height:MediaQuery.of(context).size.height/1.3,width: double.infinity,margin: EdgeInsets.all(0), padding: EdgeInsets.all(0),
                      decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10.0),)
                  ),
                   Align(
                    alignment: Alignment.topCenter,heightFactor: 1.6,
                     child: Container(
                                     margin: EdgeInsets.all(0), padding: EdgeInsets.all(5),
                      height:MediaQuery.of(context).size.height/2,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                       /* gradient: LinearGradient(begin: Alignment.topLeft,
                        end: Alignment.bottomRight,colors: [Color.fromARGB(255, 245, 4, 4),Color.fromARGB(255, 244, 252, 4)]),*/
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                          image: AssetImage('assets/images/cibo2.jpg'),
                          opacity: 5,
                          fit: BoxFit.cover,
                        ),
                      ),
                      ),
                   ), Align(
                    alignment: Alignment.bottomCenter,heightFactor:3.5,
                     child: Container(margin: EdgeInsets.all(0), padding: EdgeInsets.all(5),
                       child: Column(
                          children: [
                           // SizedBox(height:10),
                            Text(' Meal management ' + '\n',style: TextStyle(fontSize: 22, color: Colors.black,fontWeight:FontWeight.bold)),
                          //  SizedBox(height:12),
                            Text('Track your meals,'+ '\n' + 'click the button below'+ '\n'+'to get started!',style: TextStyle(fontSize: 18, color: Colors.black,fontWeight:FontWeight.bold)),
                            
                          ],
                        ),
                     ),
                   ),
                                 
                  
        ]),
                               
        ]
                ),  
    floatingActionButton: FloatingActionButton(
      child: Icon(Icons.calendar_month_rounded,color: Colors.white,),
      backgroundColor: Color.fromARGB(255, 249, 8, 8),
      onPressed: () =>Navigator.pushNamed(context, 'calendar'))
                 
                );
      
  }

  Future<String> _getName() async{
    final sp = await SharedPreferences.getInstance();
    return nome = sp.getString('name') as String;  
  }
  Future<String> _getUsername() async{
    final sp = await SharedPreferences.getInstance();
   return Email = sp.getString('username') as String;  
  }
     void _toLoginPage(BuildContext context) async {
  //Unset the 'username' filed in SharedPreference
  final sp = await SharedPreferences.getInstance();
  sp.remove('username');

  //Pop the drawer first
  Navigator.pop(context);
  //Then pop the HomePage
  Navigator.of(context).pushReplacementNamed('login');
   }  
}


