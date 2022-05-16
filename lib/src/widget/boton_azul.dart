import 'package:flutter/material.dart';

class BotonAzul extends StatelessWidget {

  final String text;
  final  onPressed;

  const BotonAzul({Key? key, required this.text, required this.onPressed}) : super(key: key);





  @override
  Widget build(BuildContext context) {
    return RaisedButton( 
      elevation: 2,
      highlightElevation: 5,
      color: Colors.blue[600],
      shape: StadiumBorder(),
      onPressed: onPressed,
      child: Container(
        width: double.infinity,
        height: 50,
        child: Center(
          child: Text(text, style: TextStyle(color: Colors.white, fontSize: 18)),
        )
      )

    );
  }
}