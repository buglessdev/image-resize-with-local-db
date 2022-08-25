import 'package:flutter/material.dart';

class ImageButton extends StatelessWidget {
  final Text label;
  final Icon icon;
  ImageButton({required this.icon, required this.label});
  @override
  Widget build(BuildContext context) {
    return Container(
        child: RaisedButton.icon(
      icon: icon,
      label: label,
      onPressed: () {},
    ));
  }
}
