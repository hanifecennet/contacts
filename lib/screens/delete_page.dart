import 'package:flutter/material.dart';

class DeletePage extends StatelessWidget {
  final String title, description, buttonText;
  final Image image;

  DeletePage({
    required this.title,
    required this.description,
    required this.buttonText,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
      ),      
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      //child: dialogContent(context),
    );
  }
}
dialogContent(BuildContext context) {
  return Stack(
    children: <Widget>[
      //...bottom card part,
      //...top circlular image part,
    ],
  );
}
