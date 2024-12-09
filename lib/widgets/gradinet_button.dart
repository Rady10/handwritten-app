import 'package:digits_app/themes/app_pallete.dart';
import 'package:flutter/material.dart';



class GradinetButton extends StatelessWidget {
  const GradinetButton({super.key, required this.buttonText, required this.onTap, required this.width});

  final String buttonText;
  final VoidCallback onTap;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Pallete.gradient1,
            Pallete.gradient2,
          ]
        ),
        borderRadius: BorderRadius.circular(10)
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: Size(width, 55),
          backgroundColor: Pallete.transparentColor,
          shadowColor: Pallete.transparentColor
        ),
        onPressed: onTap,
        child: Text(
          buttonText,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600
          ),
        ),
      ),
    );
  }
}