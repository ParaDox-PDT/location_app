import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({super.key, required this.onTap});

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.black),
        child: Icon(Icons.save_alt,color: Colors.white,),
      ),
    );
  }
}
