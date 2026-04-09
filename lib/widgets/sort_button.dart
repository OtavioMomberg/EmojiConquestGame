import 'package:flutter/material.dart';

class SortButton extends StatelessWidget {
  final Future<void> Function() onTap;

  const SortButton({required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(12),
      color: const Color.fromARGB(255, 206, 206, 207),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        splashColor: const Color.fromARGB(255, 110, 114, 123),
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:  <Widget>[
              const Icon(Icons.shuffle, color: Color.fromARGB(255, 46, 46, 47)),
              const Text(
                "SORTEAR", 
                style: TextStyle(
                  color: Color.fromARGB(255, 46, 46, 47), 
                  fontWeight: FontWeight.w600)
                ),
              const Icon(Icons.shuffle, color: Color.fromARGB(255, 46, 46, 47))
            ]
          )  
        )
      )
    );
  }
}