import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final String text;
  final Function onTap;
  final Color? btnColor;
  final Color? txtColor;
  final double? fontSize;
  final double? horizontalPadding;
  final double? verticalPadding;
  final double borderRadius;
  final bool inProgress;

  const MainButton(
      {super.key,
      required this.text,
      required this.onTap,
      this.btnColor = Colors.red,
      this.txtColor = Colors.white,
      this.horizontalPadding,
      this.inProgress = false,
      this.verticalPadding,
      required this.borderRadius,
      this.fontSize = 18});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(btnColor),
          elevation: WidgetStateProperty.all(0),
        ),
        onPressed: () => onTap(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: inProgress
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    backgroundColor: Colors.white24,
                    strokeWidth: 2,
                  ))
              : Center(
                  child: Text(
                    text,
                    style: TextStyle(color: txtColor),
                  ),
                ),
        ));
  }
}
