import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:que_paja/models/usuario.model.dart';

class UsuariosPage extends StatefulWidget {
  @override
  _UsuariosPageState createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final List<Usuario> usuarios = [
    Usuario(nombre: "Jess", email: "jessdev@gmail.com", online: true, uid: "1"),
    Usuario(nombre: "cris", email: "crisdev@gmail.com", online: true, uid: "2"),
    Usuario(
        nombre: "bray", email: "braydev@gmail.com", online: false, uid: "3"),
    Usuario(nombre: "lele", email: "leledev@gmail.com", online: true, uid: "4"),
    Usuario(nombre: "nat", email: "natdev@gmail.com", online: false, uid: "5"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Mi nombre",
        ),
        leading: IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: () {},
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.check_circle,
              color: Colors.greenAccent[400],
            ),
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
    print("Refresh");
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
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
}
