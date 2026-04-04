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
          child: SizedBox(
            height: 100,
            width: 100,    
            child: Center(
              child: Text(
                player["attack"] < 10 ? "${player["emoji"]}\n0${player["attack"]}\n" : "${player["emoji"]}\n${player["attack"]}\n" , 
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: color == Colors.black ? Colors.white : Colors.black
                )
              )
            )
          )
        ),
        childWhenDragging: Opacity(
          opacity: 0.0,
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(50)
            ),
            child: Center(
              child: Text(
                "${player["emoji"]}", 
                style: TextStyle(fontSize: 14)
              )
            )
          )
        ),
        child: Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(50)
          ),
          child: Center(
            child: Text(
              color == Colors.transparent ? "" : "Emoji!",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: color == Colors.black ? Colors.white : Colors.black
              ),
            ),
            )
        )
      )
    );
  }
}