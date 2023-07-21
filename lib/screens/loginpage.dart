import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  static const route = '/';
  static const routename = 'LoginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    //Check if the user is already logged in before rendering the login page
    _checkLogin();
  }//initState

  void _checkLogin() async {
    //Get the SharedPreference instance and check if the value of the 'username' filed is set or not
    final sp = await SharedPreferences.getInstance();
    if(sp.getString('username') != null){
      //If 'username is set, push the HomePage
      _toHomePage(context);
    }//if
  }//_checkLogin

  Future<String> _loginUser(LoginData data) async {
    if(data.name == 'flute33@expert.com' || data.name =='rolls11@expert.com' || data.name =='opera22@expert.com' ||data.name == 'cliff44@expert.com' || data.name =='toast55@expert.com' && data.password == 'prune'){

      final sp = await SharedPreferences.getInstance();
      sp.setString('username', data.name);

      return '';
    } else {
      return 'Wrong credentials';
    }
  } 
 // _loginUser
  Future<String> _signUpUser(SignupData data) async {
    return 'Not allowed';
  } 
 // _signUpUser
  Future<String> _recoverPassword(String email) async {
    return 'Recover password functionality needs to be implemented';
  } 
 // _recoverPassword
  @override
  Widget build(BuildContext context) {      
         return  Container(
            height: 800,
            width: 1400,
            decoration: BoxDecoration(
                      /*gradient: LinearGradient(begin: Alignment.topLeft,
                      end: Alignment.bottomRight,colors: [Color.fromARGB(255, 245, 4, 4),Color.fromARGB(255, 244, 252, 4)]),*/
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: AssetImage('assets/background/orange3.jpg'),
                        //opacity: 5,
                        fit: BoxFit.none,
                      ),
                    ),
               child: FlutterLogin(
                   title: 'User Login',
                //  pageColorLight :Color.fromARGB(255, 27, 2, 205), accentColor:Color.fromARGB(255, 233, 233, 236)  ),
                  onLogin: _loginUser,
                  onSignup: _signUpUser,
                   theme: LoginTheme(
                    primaryColor: Colors.white,
                pageColorLight: Colors.transparent,
                pageColorDark: Colors.transparent,
                buttonTheme : const LoginButtonTheme(backgroundColor:Color.fromARGB(255, 237, 188, 9)),
                titleStyle: GoogleFonts.aBeeZee(),
              //  cardTheme: const CardTheme(color: Colors.white)
          ),
                  //logo:'asset/images/index.png',
                  onRecoverPassword: _recoverPassword,
                  onSubmitAnimationCompleted: () async{
                    _toHomePage(context);
               
                  },
                ),
           );  
        
  } // build
  void _toHomePage(BuildContext context){
   Navigator.pushNamed(context, 'home');
  }//_toHomePage
  
  } // LoginScreen