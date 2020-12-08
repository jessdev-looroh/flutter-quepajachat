import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

mostrarAlerta(BuildContext context, String titulo, String subtitulo) {
  if (Platform.isAndroid) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(titulo),
          content: Text(subtitulo),
          actions: [
            MaterialButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Ok'),
              textColor: Colors.blue,
              elevation: 5,
            )
          ],
        );
      },
    );
  } else {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(titulo),
        content: Text(subtitulo),
        actions: [
          CupertinoDialogAction(
            child: Text('Ok'),
            isDefaultAction: true,
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }
}
