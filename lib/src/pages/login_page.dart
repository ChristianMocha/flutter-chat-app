import 'package:chat/src/helpers/mostrar_alerta.dart';
import 'package:chat/src/services/auth_services.dart';
import 'package:chat/src/widget/boton_azul.dart';
import 'package:chat/src/widget/custom_input.dart';
import 'package:chat/src/widget/labels.dart';
import 'package:chat/src/widget/logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column( 
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Logo(titulo: 'Messenger'),
                _Form(),
                Labels(ruta: 'register', pregunta: '¿No tienes una cuenta?', navegacion: 'Crea una ahora!'),
                Text('Terminos y condicones de uso', style: TextStyle(fontWeight: FontWeight.w200)),
              ]
            ),
          ),
        ),
      )
    );
  }
}



class _Form extends StatefulWidget {
  _Form({Key? key}) : super(key: key);
  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Container(
      
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 30),

      child: Column(
        children: <Widget>[
          
          CustomInput(
            icon: Icons.mail_outline,
            placeholder: 'Correo',
            textController: emailController,
            keyboardType: TextInputType.emailAddress,
          ),
          CustomInput(
            icon: Icons.lock_outline,
            placeholder: 'Contraseña',
            textController: passwordController,
            isPassword: true,
          ),

          BotonAzul(
            text: 'Ingresar',
            onPressed: authService.autenticando ? null : () async{
              FocusScope.of(context).unfocus();
              final loginOK = await authService.login(emailController.text.trim(), passwordController.text.trim(),);
              if(loginOK){
                // TODO: Conectar a nuestro SocketServer
                Navigator.pushReplacementNamed(context, 'usuarios');
              }else{
                mostrarAlerta(context,'Error!', 'Usuario o contraseña incorrectos');
              }
            }
          ),
          
        ]
      ),
    );
  }
}











