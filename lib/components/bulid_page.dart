import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class buildPage extends StatelessWidget {
   buildPage({super.key,required this.celor,required this.image,required this.title,required this.subtitle });
Color celor;
String image;
String title;
String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: celor,
      child: Column(children: 
      [
        SizedBox(height: 40,),
        Image.asset(image,fit: BoxFit.cover,width: double.infinity,),
        SizedBox(height: 64,),
        Text('$title',style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold,color: Colors.teal.shade700),),
        SizedBox(height: 24,),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text('$subtitle',style: TextStyle(color:Colors.black ) ,),
        )
        ]),
      
    );
  }
}