import 'package:flutter/material.dart';

class SortButton extends StatelessWidget {
  final Future<void> Function() onTap;

  const SortButton({required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(12),
      type: MaterialType.card,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const <Widget>[
              Icon(Icons.shuffle),
              Text("SORT"),
              Icon(Icons.shuffle)
            ]
          )  
        )
      )
    );
  }
}