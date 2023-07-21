import 'dart:ui';

import 'package:flutter/material.dart';

class PetsButtonsWidgetL extends StatelessWidget {
  final List<String?> pets;
  final ValueChanged<String> onSelectedPet;

  const PetsButtonsWidgetL({
    Key? key,
    required  this.pets,
    required this.onSelectedPet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final background = Theme.of(context).unselectedWidgetColor;
    final allPets = ['first course', 'second course', 'side dish','dessert'];
    Size screenSize = MediaQuery.of(context).size;

    return  Container(
       decoration: BoxDecoration(
           boxShadow: [
     /* BoxShadow(
        color: Colors.grey.withOpacity(1),
        spreadRadius: 5,
        blurRadius: 6,
        offset: Offset(0, 3), // changes position of shadow
      ),*/
    ],
          borderRadius: BorderRadius.circular(10),
          color:Colors.orange,
            border: Border.all(color: Color.fromARGB(255, 8, 8, 8),width: 2),
        ),
        child: Column(
              children: [
              Container(
                   decoration: BoxDecoration(
          borderRadius:  BorderRadius.only(topLeft: Radius.circular(5),topRight: Radius.circular(5))),
                alignment: Alignment.center,width: screenSize.width /1.05,height: screenSize.height /13 , child: Row(
                  children: [ 
                     SizedBox(width:16),
                    Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Image(image: AssetImage("assets/images/pizza2.png")),
                  ),
                SizedBox(width:screenSize.width /5),
                    Text('Lunch',style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold, fontSize: 17)),
                  ],

                )),
             ToggleButtons(
                        isSelected: allPets.map((pet) => pets.contains(pet)).toList(),
                        selectedColor:Colors.white,
                        color: Colors.white,
                        constraints: BoxConstraints(minWidth: 0, maxWidth:screenSize.width/3.6,minHeight: 50,maxHeight: 160),
                        fillColor:  Color.fromARGB(255, 66, 64, 64),
                        textStyle:TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
                        borderRadius: BorderRadius.circular(10),
                        renderBorder: true,
                        children: allPets.map(buildPet).toList(),
                        onPressed: (index) => onSelectedPet(allPets[index]),
                      ),  
              ],
            ),
   
    );
  }

  Widget buildPet(String text) => 
    Container(
           padding: EdgeInsets.symmetric(horizontal: 3),
         margin: EdgeInsets.all(5.0),
        // padding: EdgeInsets.all(3.0),
          child: Text(text),
            decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
        );  
}
