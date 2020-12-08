import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:que_paja/models/usuario.model.dart';
import 'package:que_paja/models/usuario_response.model.dart';
import 'package:que_paja/services/auth.service.dart';
import 'package:que_paja/services/chat_service.dart';
import 'package:que_paja/services/socket.service.dart';
import 'package:que_paja/services/usuario.service.dart';

class UsuariosPage extends StatefulWidget {
  @override
  _UsuariosPageState createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  UsuarioService usuarioService = UsuarioService();
  List<Usuario> usuarios = [];

  @override
  void initState() {
    _cargaUsuarios();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);

    final user = authService.usuario;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          user.nombre,
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          color: Colors.red[200],
          icon: Icon(Icons.exit_to_app),
          onPressed: () {
            socketService.disconnect();
            AuthService.deleteToken();
            Navigator.pushReplacementNamed(context, "login");
          },
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: socketService.serverStatus == ServerStatus.Online
                ? Icon(Icons.check_circle, color: Colors.greenAccent[400])
                : Icon(Icons.offline_bolt, color: Colors.red[400]),
          )
        ],
      ),
      body: SmartRefresher(
        enablePullDown: true,
        header: WaterDropHeader(
          refresh: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 10,
                width: 10,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              ),
              SizedBox(width: 10),
              Text("Recargando usuarios...",
                  style: TextStyle(color: Colors.grey[500]))
            ],
          ),
          failed: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, color: Colors.red[400]),
              SizedBox(width: 10),
              Text("Falló la carga...",
                  style: TextStyle(color: Colors.red[500]))
            ],
          ),
          waterDropColor: Colors.blue,
          idleIcon: Icon(
            Icons.refresh,
            color: Colors.white,
            size: 15,
          ),
          complete: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check, color: Colors.blue[400]),
              SizedBox(width: 10),
              Text("Carga completa...",
                  style: TextStyle(color: Colors.grey[500]))
            ],
          ),
        ),
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        controller: _refreshController,
        child: _listveiewUsuarios(),
      ),
    );
  }

  ListView _listveiewUsuarios() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (_, i) {
        final user = usuarios[i];
        return _usuarioListTile(user);
      },
      itemCount: usuarios.length,
      separatorBuilder: (_, i) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          height: 1,
          width: double.infinity,
          color: Colors.grey[300],
        );
      },
    );
  }

  void _onRefresh() async {
    // monitor network fetch
    _cargaUsuarios();

    // if failed,use refreshFailed()

    // _refreshController.refreshFailed();
  }

  void _onLoading() async {
    // monitor network fetch
    print("Loading");
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    usuarios.add(Usuario(
        nombre: (usuarios.length + 1).toString(),
        online: false,
        email: "correo@empresa.com",
        uid: (usuarios.length + 1).toString()));
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  ListTile _usuarioListTile(Usuario user) {
    return ListTile(
      onTap: () => goToChat(user),
      leading: CircleAvatar(
        backgroundColor: Colors.blue[200],
        foregroundColor: Colors.white,
        child: Text(user.nombre.substring(0, 2).toUpperCase()),
      ),
      trailing: Container(
        height: 10,
        width: 10,
        decoration: BoxDecoration(
          color: user.online ? Colors.greenAccent[400] : Colors.red[400],
          shape: BoxShape.circle,
        ),
      ),
      title: Text(user.nombre),
      subtitle: Text(user.email),
    );
  }

  _cargaUsuarios() async {
    this.usuarios = await usuarioService.getUsuarios();
    setState(() {});
    _refreshController.refreshCompleted();
  }

  goToChat(Usuario user) {
    final chatService = Provider.of<ChatService>(context, listen: false);
    chatService.usuarioPara = user;
    Navigator.pushNamed(context, 'chat');
  }
}
