import 'package:flutter/material.dart';
import 'package:marvel_app/helpers/constants.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({super.key, required this.asset, required this.onTap});
  final String asset ;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){onTap();},
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color:mainColor.withOpacity(0.1) ),
          borderRadius: BorderRadius.circular(8),
        ),
      height: 40,
      width: 40,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(asset),
        ),
      ),
    );
  }
}