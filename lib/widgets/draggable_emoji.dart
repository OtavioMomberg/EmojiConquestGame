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
          shape: StarBorder.polygon(sides: 6, pointRounding: 0.3),
          elevation: 8,
          shadowColor: color.withValues(alpha: 0.5),
          child: SizedBox(
            height: 95,
            width: 100,    
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
        childWhenDragging: Material(
          color: const Color.fromARGB(255, 46, 46, 47),
          shape: StarBorder.polygon(sides: 6, pointRounding: 0.3),
          elevation: 8,
          shadowColor: const Color.fromARGB(255, 36, 37, 39).withValues(alpha: 0.3),
          child: SizedBox(
            height: 95,
            width: 100, 
          )
        ),
        child: Material(
          color: color.withValues(alpha: 0.8),
          shape: StarBorder.polygon(sides: 6, pointRounding: 0.3),
          elevation: 8,
          child: SizedBox(
            height: 95,
            width: 100,
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
          )
        )
      )
    );
  }
}