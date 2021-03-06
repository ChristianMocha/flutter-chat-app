import 'package:chat/src/models/usuario.dart';
import 'package:chat/src/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class UsuariosPage extends StatefulWidget {
  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  final usuarios = [
    Usuario(uid: '1', nombre: 'Juan', email: 'test1@mail.com', online: true),
    Usuario(uid: '2', nombre: 'Pedro', email: 'test2@mail.com', online: false),
    Usuario(uid: '3', nombre: 'Criss', email: 'test3@mail.com', online: true),
  ];

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);
    final usuario = authService.usuario;

    return Scaffold(
      appBar: AppBar(
        title: Text(usuario!.nombre.toString(), style: TextStyle(color: Colors.black87)),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.exit_to_app, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacementNamed(context, 'login');
            AuthService().logout();
          },
        ),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Icon( Icons.check_circle, color: Colors.blue),
            // child: Icon( Icons.offline_bolt, color: Colors.blue),
          )
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _cargarUsuarios,
        header: WaterDropMaterialHeader(),
        child: _ListViewUsuarios()
      ),
    );
  }

  ListView _ListViewUsuarios() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (_, i) => _usuarioListTile(usuarios[i]),

      separatorBuilder: (_, i) => Divider(),
      itemCount: usuarios.length,
    );
  }

  ListTile _usuarioListTile(Usuario usuarios) {
    return ListTile(
        title: Text(usuarios.nombre.toString()),
        subtitle: Text(usuarios.email.toString()),
        leading: CircleAvatar(
          child: Text(usuarios.nombre.toString().substring(0,2)),
          backgroundColor: Colors.blue[100],
        ), 
        trailing: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: usuarios.online ? Colors.green[300] : Colors.red[300],
            borderRadius: BorderRadius.circular(100),
          )
        )
      );
  }

  _cargarUsuarios()async {
    
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();


  }
}