import 'package:flutter/material.dart';
import 'package:marvel_app/helpers/constants.dart';

class AltButton extends StatelessWidget {
  final String text;
  final Function onTap;
  final Color? btnColor;
  final Color? txtColor;
  final double? fontSize;
  final double? horizontalPadding;
  final double? verticalPadding;
  final double borderRadius;
  final bool inProgress;

  const AltButton(
      {super.key,
      required this.text,
      required this.onTap,
      this.btnColor = Colors.white,
      this.txtColor = Colors.red,
      this.horizontalPadding,
      this.inProgress = false,
      this.verticalPadding,
      required this.borderRadius,
      this.fontSize = 18});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: 
      
      ElevatedButton(
        
          style: ElevatedButton.styleFrom(

            side: BorderSide(
              width: borderRadius,
              color: Colors.red
            ),
            backgroundColor: btnColor,
            elevation: 0,
          ),
          onPressed: () => onTap(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: inProgress
                ? SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: mainColor,
                      backgroundColor: Colors.white24,
                      strokeWidth: 2,
                    ))
                : Center(
                    child: Text(
                      text,
                      style: TextStyle(color: txtColor, fontWeight: FontWeight.w900),
                    ),
                  ),
          ),
          
          ),
    );
  }
}
