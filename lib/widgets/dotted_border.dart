import 'package:digits_app/themes/app_pallete.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

class DottedBox extends StatelessWidget {
  const DottedBox({super.key, required this.text, required this.icon});
  final String text;
  final Icon icon;
  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      dashPattern: const [10, 4],
      radius: const Radius.circular(10),
      borderType: BorderType.RRect,
      strokeCap: StrokeCap.round,
      color: Pallete.whiteColor,
      child: SizedBox(
        height: 159,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(height: 15,),
            Text(
              text,
              style: const TextStyle(
                fontSize: 15,
                color: Pallete.whiteColor
              ),
            ),
          ],
        ),
      ),
    );
  }
}