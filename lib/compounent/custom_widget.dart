import 'package:flutter/material.dart';

typedef Validator=String? Function(String?)?;

class CustomFormFeild extends StatelessWidget {
String label;
TextInputType keyboardtype;
bool ispassword;
TextEditingController controller;
Validator myValidator;
CustomFormFeild({required this.label,
this.keyboardtype=TextInputType.text,
  this.ispassword=false,
  required this.controller,
  required this.myValidator
});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        keyboardType:keyboardtype ,
        obscureText: ispassword,
        controller:controller ,
        validator: myValidator,
        decoration: InputDecoration(
          label: Text(label,),
          //labelStyle: const TextStyle(color: Colors.black),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColorLight,
              width: 4,
            )
          ),
            focusedBorder:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColorLight,
                  width: 4,
                )
        ),
        ),

      ),
    );
  }
}
