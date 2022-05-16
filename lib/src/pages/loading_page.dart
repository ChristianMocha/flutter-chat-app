import 'package:chat/src/pages/login_page.dart';
import 'package:chat/src/pages/usuarios_page.dart';
import 'package:chat/src/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (context, snapshot) {
          return Center(
            child: Container(
              child: Text('Espere...'),
            ),
          );
        }
      ),
    );
  }

  Future checkLoginState(BuildContext context) async{
    final authService = Provider.of<AuthService>(context);
    final autenticado = await authService.isLoggedIn();

    if(autenticado){
      Navigator.pushReplacement(
        context, 
        PageRouteBuilder(
          pageBuilder: ( _, __, ___) => UsuariosPage(),
          transitionDuration: Duration(milliseconds: 0),
        )
      );
    }else{
      Navigator.pushReplacement(
        context, 
        PageRouteBuilder(
          pageBuilder: ( _, __, ___) => LoginPage(),
          transitionDuration: Duration(milliseconds: 0),
        )
      );
    }
  }
}