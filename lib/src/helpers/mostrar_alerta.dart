import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

mostrarAlerta( BuildContext context, String titulo, String Subtitulo){

  if( Platform.isAndroid ){
    return showDialog( 
      context: context,
      builder: (_) => AlertDialog(
        title: Text(titulo),
        content: Text(Subtitulo),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            // elevation: 5,
            textColor: Colors.blue,
            onPressed: () => Navigator.pop(context),
          )
        ],
      )
    );
  }

  showCupertinoDialog(
    context: context,
    builder: (_) => CupertinoAlertDialog(
      title: Text(titulo),
      content: Text(Subtitulo),
      actions: <Widget>[
        CupertinoDialogAction(
          isDefaultAction: true,
          child: Text('Ok!'),
          onPressed: () => Navigator.pop(context),
        )
      ],
    )
  );

}