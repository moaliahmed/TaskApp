import 'package:finelproject/appColors/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyButton extends StatelessWidget {
  MyButton(
      {super.key,
      this.colorContainer,
      required this.buttonName,
      this.iconButton,
      required this.function,
       this.active=false,
      this.width = 90});
      Color? colorContainer;
      
bool active ;
  String buttonName;
  Icon? iconButton;
  Function function;
  double? width;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        function();
      },
      child: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(3),
        height: 50,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.black, width: 2),
            gradient:
            active?
            LinearGradient(   
              colors: [
              AppColor.kmainColor, 
              AppColor.kmainColor,
              Colors.teal[100]!
            ]
            ): LinearGradient(   
              colors: [
              AppColor.kmainColor,
              AppColor.kmainColor,
             
            ]
            
            ),),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              iconButton != null
                  ? IconTheme(data: IconThemeData(size: 32), child: iconButton!)
                  : SizedBox(),
              Text(
                buttonName,
                style: TextStyle(fontSize: 22),
              )
            ],
          ),
        ),
      ),
    );
  }
}
