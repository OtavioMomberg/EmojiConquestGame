import 'package:flutter/material.dart';

class BasicButton extends StatelessWidget {
  final void Function(BuildContext) play;
  final String text;
  const BasicButton({required this.play, required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      shadowColor: const Color.fromARGB(255, 206, 206, 207).withValues(alpha: 0.3),
      color: const Color.fromARGB(255, 206, 206, 207),
      borderRadius: BorderRadius.circular(12),
      surfaceTintColor: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        splashColor: const Color.fromARGB(255, 110, 114, 123),
        onTap: () => play(context),
        child: SizedBox(
          height: 60,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF001F40).withValues(alpha: 0.6),
              )
            )
          )
        )
      )
    );
  }
}