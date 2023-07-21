import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

///Class that implement a custom-made [ListTile] to manage textboxes containing strings in a [Form].
///You must provide a controller, a label that is shown as helper, and an icon. This is checked via a regex.
///The [FormTextTile] content is valid if it is not empty.
class FormTextTile extends ListTile {
  final controller;
  final labelText;
  final icon;

  FormTextTile({this.icon, this.controller, this.labelText});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).accentColor),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: screenSize.width / 0.5,
            child: TextFormField(
              controller: controller,
              validator: (value) => value == "" ? 'Must not be empty.' : null,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: labelText,
                focusColor: Theme.of(context).accentColor,
              ),
            ),
          ),
        ],
      ),
    );
  } // build
} // FormTextTile

///Class that implement a custom-made [ListTile] to manage textboxes containing numbers in a [Form].
///You must provide a controller, a label that is shown as helper, and an icon.
///The [FormNumberTile] content is valid if it contains numbers only. This is checked via a regex.
class FormNumberTile extends ListTile {
  final controller;
  final labelText;
  final icon;

  FormNumberTile({this.icon, this.controller, this.labelText});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).accentColor),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: screenSize.width / 1.5,
            child: TextFormField(
              controller: controller,
              validator: (value) {
                String? ret;
                String pattern = r'^(0*[1-9][0-9]*(\.[0-9]*)?|0*\.[0-9]*[1-9][0-9]*)$';
                RegExp regex = RegExp(pattern);
                if(!regex.hasMatch(value!))
                  ret = 'Must be a number.';
                return ret;
              },
              keyboardType: TextInputType.numberWithOptions(signed: true),
              decoration: InputDecoration(
                labelText: labelText,
              ),
            ),
          ),
        ],
      ),
    );
  } // build
} // FormTextTile

///Class that implement a custom-made [ListTile] to manage textboxes containing dates in a [Form].
///You must provide a label that is shown as helper, the date to show, an icon, a callback to define the behaviour of the field when it is tapped, and a [DateFormat].
///The [FormDateTile] content is always valid and it should be guaranteed via a DatePicker.
class FormDateTile extends ListTile {
  final labelText;
  final date;
  final icon;
  final onPressed;
  final DateFormat dateFormat;

  FormDateTile(
      {this.icon,
      this.labelText,
      this.date,
      required this.dateFormat,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return 
         Container( height:MediaQuery.of(context).size.height/6,
                 decoration: BoxDecoration(
                   color: Colors.white,
          borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(begin: Alignment.topLeft,
                  end: Alignment.bottomRight,colors: [Colors.white,Colors.white]),
        ),
                  alignment: Alignment.center,
                  width: screenSize.width,
                  child:                      
                        ListTile(
                        
                           leading:Image(image: AssetImage("assets/images/schedule.png"),width:MediaQuery.of(context).size.width/6,height:MediaQuery.of(context).size.height/6),
                        title: 
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 1.0),
                                    child: FlatButton(
                                    child: Text(DateFormat('EEEE').format(date)+'    ' ,style: TextStyle(color: Colors.black,fontSize: 22,fontStyle: FontStyle.italic,fontWeight:FontWeight.bold,)),
                                    onPressed: onPressed,
                                ),
                                  ),
                            subtitle:  
                                   //   SizedBox(width: 40),
                                      Row(
                                        children: [
                                           SizedBox(width: 30),
                                          FlatButton( 
                                          child: Text(DateFormat('dd/MM/yyyy').format(date),style: TextStyle(color: Colors.black,fontSize: 18),),
                                          onPressed: onPressed),
                                              //   SizedBox(width: 50),
                                   IconButton(icon: Icon(Icons.arrow_drop_down,color: Colors.black),onPressed:onPressed),
                                        ],
                                      ),
                         
                            
                                
                        )
                    
                );

  } // build
} // FormDateTile

///Class that implement a custom-made [ListTile] to manage dropdown menus containing numbers in a [Form].
///You must provide a label that is shown as helper, the value to show, the items to show, a callback to define the behaviour of the field when it changes, and an icon.
///The [DropdownButtonTileNumber] content is always valid since it is guaranteed by the fact that the values it can assumes are provided by the user.
class DropdownButtonTileNumber extends ListTile {
  final value;
  final items;
  final labelText;
  final icon;
  final onChanged;

  DropdownButtonTileNumber(
      {this.icon,
      this.value,
      this.items,
      this.labelText,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).accentColor),
      title: Container(
        width: screenSize.width / 1.5,
        child: DropdownButton<int>(
          isExpanded: false,
          value: value,
          onChanged: onChanged,
          items: items.map<DropdownMenuItem<int>>((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text('${value.toString()}'),
                      );
                    })
                    .toList(),
        ),
      ),
    );
  } // build
} // DropdownButtonTileNumber

///Class that implement a custom-made [ListTile] to manage dropdown menus containing strings in a [Form].
///You must provide a label that is shown as helper, the value to show, the items to show, a callback to define the behaviour of the field when it changes, and an icon.
///The [DropdownButtonTileString] content is always valid since it is guaranteed by the fact that the values it can assumes are provided by the user.
class DropdownButtonTileString extends ListTile {
  final value;
  final items;
  final labelText;
  final icon;
  final onChanged;

  DropdownButtonTileString(
      {this.icon,
      this.value,
      this.items,
      this.labelText,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).accentColor),
      title: Container(
        width: screenSize.width / 1.5,
        child: DropdownButton<String>(
          isExpanded: false,
          value: value,
          onChanged: onChanged,
          items: items.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text('$value'),
                      );
                    })
                    .toList(),
        ),
      ),
    );
  } // build
} // DropdownButtonTileString