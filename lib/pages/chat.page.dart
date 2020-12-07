import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:que_paja/widgets/chat_message.widget.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textController = TextEditingController();
  final _focusNode = new FocusNode();

  List<ChateMessage> _mensajes = [
    // ChateMessage(texto: "hola mundo", uid: "123"),
    // ChateMessage(texto: "hola mundo", uid: "123"),
    // ChateMessage(texto: "hola mundo", uid: "1234"),
    // ChateMessage(texto: "hola mundo", uid: "123"),
    // ChateMessage(texto: "hola mundo", uid: "123"),
    // ChateMessage(texto: "hola mundo", uid: "1234"),
    // ChateMessage(texto: "hola mundo", uid: "123"),
    // ChateMessage(texto: "hola mundo", uid: "123"),
    // ChateMessage(texto: "hola mundo", uid: "1234"),
  ];
  bool _estaEscribiendo = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          children: [
            CircleAvatar(
              maxRadius: 12,
              child: Text("TE",
                  style: TextStyle(color: Colors.white, fontSize: 10)),
              backgroundColor: Colors.red[200],
            ),
            SizedBox(height: 3),
            Text(
              "Melissa Flores",
              style: TextStyle(color: Colors.black87, fontSize: 12),
            )
          ],
        ),
        centerTitle: true,
        elevation: 1,
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
              child: _listviewMensajes(),
            ),
            Divider(height: 1),
            //TODO: caja de texto
            Container(
              color: Colors.white,
              child: _inputChat(),
            )
          ],
        ),
      ),
    );
  }

  ListView _listviewMensajes() {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: _mensajes.length,
      itemBuilder: (_, index) => _mensajes[index],
      reverse: true,
    );
  }

  Widget _inputChat() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: (value) {
                  if (value.length > 0) _handleSubmit(value);
                  _textController.clear();
                  _focusNode.requestFocus();
                },
                onChanged: (value) {
                  setState(() {
                    if (value.trim().length > 0)
                      this._estaEscribiendo = true;
                    else
                      this._estaEscribiendo = false;
                  });
                },
                focusNode: _focusNode,
                decoration:
                    InputDecoration.collapsed(hintText: 'Enviar mensaje'),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 2),
              child: (Platform.isIOS)
                  ? CupertinoButton(
                      child: Text("Enviar"),
                      onPressed: _estaEscribiendo
                          ? () => _handleSubmit(_textController.text)
                          : null,
                    )
                  : Container(
                      margin: EdgeInsets.symmetric(horizontal: 2),
                      child: IconButton(
                        splashRadius: 1,
                        color: Colors.red[400],
                        icon: Icon(Icons.send),
                        onPressed: _estaEscribiendo
                            ? () => _handleSubmit(_textController.text)
                            : null,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  _handleSubmit(String text) {
    if (text.length > 0) print(text);

    _textController.clear();
    _focusNode.requestFocus();
    final newMessage = ChateMessage(
      uid: '123',
      texto: text,
      animationController: AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 400),
      ),
    );
    newMessage.animationController.forward();
    _mensajes.insert(0, newMessage);
    setState(() {
      _estaEscribiendo = false;
    });
  }

  @override
  void dispose() {
    _mensajes.forEach((element) {
      element.animationController.dispose();
    });
    super.dispose();
  }
}
