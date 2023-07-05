import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medcare/theme.dart';

class MyButton extends StatelessWidget {
  final String label;
  final Function()? onPressed;
  const MyButton({Key? key, required this.label, required this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 110,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: primaryClr),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
