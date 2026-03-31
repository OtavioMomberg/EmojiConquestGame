import 'package:flutter/material.dart';

class FieldClassInfo extends StatelessWidget {
  final void Function(int) seeInfo;
  final int imageIndex;
  const FieldClassInfo({required this.seeInfo, required this.imageIndex, super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.card,
      color: Colors.amberAccent,
      borderRadius: BorderRadius.circular(50),
      child: InkWell(
        onTap: () => seeInfo(imageIndex),
        child: Icon(Icons.help_outline),
      ),
    );
  }
}