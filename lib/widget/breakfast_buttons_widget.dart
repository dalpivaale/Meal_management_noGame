import 'package:flutter/material.dart';

class PetsButtonsWidgetB extends StatelessWidget {
 final String pets;
  final ValueChanged<String> onSelectedPet;

  const PetsButtonsWidgetB({
    Key? key,
    required  this.pets,
    required this.onSelectedPet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final background = Theme.of(context).unselectedWidgetColor;
    final allPets = ['continental', 'english', 'american'];
    Size screenSize = MediaQuery.of(context).size;

    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.orange,
           border: Border.all(color: Colors.black,width: 2),
        ),
        child: Column(         
          children: [
            Container(
           decoration: BoxDecoration(
          borderRadius:  BorderRadius.only(topLeft: Radius.circular(5),topRight: Radius.circular(5))),
              width: screenSize.width /1.035,
              height:  screenSize.height /13,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Image(image: AssetImage("assets/images/pancakes.png")),
                  ),
                SizedBox(width:screenSize.width /5),
                 Text('Breakfast',style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold, fontSize: 17)),
                ],
              )),
               ToggleButtons(
                constraints: BoxConstraints(minWidth: 0,maxWidth:screenSize.width/3.1,minHeight: 50,maxHeight: 160),
                  isSelected: allPets.map((pet) => pets.contains(pet)).toList(),
                  selectedColor:Colors.white, //colore scrittta bottone
                  color: Colors.white,
                  textStyle:TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
                  fillColor:  Color.fromARGB(255, 66, 64, 64),
                  borderRadius: BorderRadius.circular(6),
               // borderColor: Colors.black,
                  renderBorder: true,
                  children: allPets.map(buildPet).toList(),
                  onPressed: (index) => onSelectedPet(allPets[index]),
              ),
     
          ],
        ),
      );
  }

  Widget buildPet(String text) { return 
      Row(
        children: [        
          Container(
                padding: EdgeInsets.symmetric(horizontal:10),
                child: Text(text,style: TextStyle(color: Color.fromARGB(255, 248, 246, 246)),),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
               SizedBox(width:5),
        ],
      );
  }
}
