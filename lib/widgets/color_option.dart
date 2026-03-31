import 'package:flutter/material.dart';

class ColorOption extends StatelessWidget {
  final int index;
  final Color cor;
  final bool selectedColor;

  const ColorOption({
    required this.index,
    required this.cor,
    required this.selectedColor,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        border: Border.all(
          color: selectedColor ? Colors.black : Colors.white,
          width: 2
        ),
        borderRadius: BorderRadius.circular(50)
      ),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50)
        ),
        color: cor
      )
    );
  }
}