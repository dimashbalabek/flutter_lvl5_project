import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HabitTile extends StatelessWidget {
  const HabitTile({super.key, required this.habitCompleted, required this.habitName, this.onChanged, this.settingsTapped, this.deleteTapped});

  final String habitName;
  final bool habitCompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? settingsTapped;
  final Function(BuildContext)? deleteTapped;


  @override
  Widget build(BuildContext context) {
    return Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Slidable(
              endActionPane: ActionPane(
                motion: const StretchMotion(), 
                children: [
                  // settings option 
                  SlidableAction(
                    borderRadius: BorderRadius.circular(20),
                    onPressed: settingsTapped,
                    backgroundColor: Colors.purple.shade600,
                    icon: (Icons.settings)
                  ),
                  // delete optioon
                  SlidableAction(
                    borderRadius: BorderRadius.circular(20),
                    onPressed: deleteTapped,
                    backgroundColor: Colors.red.shade600,
                    icon: (Icons.delete)
                  ),
                ]
              ),
              
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Checkbox(
                      value: habitCompleted,
                       onChanged: onChanged
                       ),
                    Text(habitName),
                    // Icon(Icons.settings)
                  ],
                ),
              ),
            ),
          );
  }
}