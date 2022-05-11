import 'package:flutter/material.dart';


class Labels extends StatelessWidget {

  final String ruta;
  final String pregunta;
  final String navegacion;

  const Labels({Key? key, required this.ruta, required this.pregunta, required this.navegacion}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(pregunta, style: TextStyle(color: Colors.black54, fontSize: 15)),
          SizedBox(height: 16),
          GestureDetector(
            child: Text(navegacion, style: TextStyle(color: Colors.blue[600], fontSize: 18, fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.pushReplacementNamed(context, ruta);
            }            
          ),
        ]
      )
    );
  }
}