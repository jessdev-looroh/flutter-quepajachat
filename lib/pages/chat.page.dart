import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:que_paja/models/message.model.dart';
import 'package:que_paja/models/usuario.model.dart';
import 'package:que_paja/services/auth.service.dart';
import 'package:que_paja/services/chat_service.dart';
import 'package:que_paja/services/socket.service.dart';
import 'package:que_paja/widgets/chat_message.widget.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textController = TextEditingController();
  final _focusNode = new FocusNode();
  Usuario userYo;
  Usuario userPara;
  AuthService authService;
  ChatService chatService;
  SocketService socketService;
  List<ChateMessage> _mensajes = [];
  bool _estaEscribiendo = false;

  @override
  void initState() {
    chatService = Provider.of<ChatService>(context, listen: false);
    authService = Provider.of<AuthService>(context, listen: false);
    socketService = Provider.of<SocketService>(context, listen: false);
    userYo = authService.usuario;
    userPara = chatService.usuarioPara;
    socketService.socket.on('enviarMensajePersonal', _escucharMensajes);
    _cargarHistorial(this.chatService.usuarioPara.uid);
    super.initState();
  }

  _escucharMensajes(dynamic data) {
    ChateMessage message = ChateMessage(
      texto: data['mensaje'],
      uid: data['de'],
      animationController: AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 300),
      ),
    );
    setState(() {
      _mensajes.insert(0, message);
    });
    message.animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          children: [
            CircleAvatar(
              maxRadius: 12,
              child: Text(userPara.nombre.substring(0, 2).toUpperCase(),
                  style: TextStyle(color: Colors.white, fontSize: 10)),
              backgroundColor: Colors.red[200],
            ),
            SizedBox(height: 3),
            Text(
              userPara.nombre,
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
              child: Stack(
                children: [
                  Container(
                    child: Image.asset(
                      "assets/fondo2.jpg",
                      fit: BoxFit.fill,
                    ),
                    height: double.infinity,
                    width: double.infinity,
                  ),
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    color: Colors.grey[800].withOpacity(0.8),
                  ),
                  _listviewMensajes(),
                ],
              ),
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
      padding: EdgeInsets.only(bottom: 10, top: 10),
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
    // if (text.length > 0);

    _textController.clear();
    _focusNode.requestFocus();
    final newMessage = ChateMessage(
      uid: userYo.uid,
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
    this.socketService.socket.emit(
      'enviarMensaje',
      {"de": userYo.uid, "para": userPara.uid, "mensaje": text},
    );
  }

  @override
  void dispose() {
    _mensajes.forEach((element) {
      element.animationController.dispose();
    });
    socketService.socket.off('enviarMensajePersonal');
    super.dispose();
  }

  void _cargarHistorial(String uid) async {
    List<Mensaje> chat = await chatService.getChat(uid);

    _mensajes = chat
        .map(
          (e) => ChateMessage(
            texto: e.mensaje,
            uid: e.de,
            animationController: new AnimationController(
                vsync: this, duration: Duration(milliseconds: 0))
              ..forward(),
          ),
        )
        .toList();
    setState(() {});
  }
}
