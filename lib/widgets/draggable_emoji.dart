import 'package:flutter/material.dart';

class DraggableEmoji extends StatelessWidget {
  final Map<String, dynamic> player;
  final bool isSorted;
  final Color color;
  
  const DraggableEmoji({
    required this.player,
    required this.isSorted, 
    required this.color,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: isSorted ? false : true,
      child: Draggable<Map<String, dynamic>>(
        data: player,
        feedback: Material(
          color: color.withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(50),
          elevation: 8,
          shadowColor: color.withValues(alpha: 0.5),
          child: SizedBox(
            height: 80,
            width: 80,    
            child: Center(
              child: Text(
                player["attack"] < 10 
                  ? "${player["emoji"]}\n0${player["attack"]}" 
                  : "${player["emoji"]}\n${player["attack"]}", 
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: color == Colors.black 
                    ? const Color.fromARGB(255, 206, 206, 207) 
                    : const Color.fromARGB(255, 33, 32, 32)
                )
              )
            )
          )
        ),
        childWhenDragging: Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              style: BorderStyle.solid,
              color: color
            )
          )  
        ),
        child: Material(
          color: color.withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(50),
          elevation: 8,
          child: SizedBox(
            height: 80,
            width: 80,
            child: Center(
              child: Text(
                color == Colors.transparent ? "" : "Emoji",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                    color: color == Colors.black 
                      ? const Color.fromARGB(255, 206, 206, 207) 
                      : const Color.fromARGB(255, 33, 32, 32)
                )
              )
            )
          ),
        )
      )
    );
  }
}