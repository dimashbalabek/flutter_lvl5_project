import 'package:flutter/material.dart';

class MyAlertBox extends StatelessWidget {
  const MyAlertBox({super.key, this.controller, required this.onSave, required this.onCancel, required this.hintext});

  final controller ;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final String hintext;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: TextField(
        
        controller: controller,
        decoration: InputDecoration(
          hintText: hintext,
          border: OutlineInputBorder()
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: onCancel,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Adjust the radius here
            ),
            backgroundColor: Colors.purple[400], // Optional: Change the button color
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Optional: Adjust padding
            ),
            child: const Text("Cancel", style: TextStyle(color: Colors.white),),
            ),

        ElevatedButton(
          onPressed: onSave,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Adjust the radius here
            ),
            backgroundColor: Colors.purple[400], // Optional: Change the button color
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Optional: Adjust padding
            ),
            child: const Text("Save", style: TextStyle(color: Colors.white),),
            ),


      ],
    );
  }
}