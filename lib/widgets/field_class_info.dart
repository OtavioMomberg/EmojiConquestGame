import 'package:flutter/material.dart';

class FieldClassInfo extends StatelessWidget {
  final void Function(int) seeInfo;
  final int imageIndex;
  const FieldClassInfo({required this.seeInfo, required this.imageIndex, super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color.fromARGB(255, 71, 112, 189),
      borderRadius: BorderRadius.circular(50),
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: () => seeInfo(imageIndex),
        child: Icon(Icons.help_outline, color: Color.fromARGB(255, 206, 206, 207).withValues(alpha: 0.7)),
      )
    );
  }
}