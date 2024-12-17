import 'package:flutter/material.dart';

class MyFloatingActionButton extends StatelessWidget {
  const MyFloatingActionButton({super.key, this.onpressed});

  final Function()? onpressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onpressed,
      child: const Icon(Icons.add),
      );
  }
}