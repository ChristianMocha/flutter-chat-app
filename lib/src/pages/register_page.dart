import 'package:chat/src/widget/boton_azul.dart';
import 'package:chat/src/widget/custom_input.dart';
import 'package:chat/src/widget/labels.dart';
import 'package:chat/src/widget/logo.dart';
import 'package:flutter/material.dart';


class RegisterPage extends StatelessWidget {

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
                Logo(titulo: 'Registrar'),
                _Form(),
                Labels(ruta: 'login', pregunta: '¿Ya tienes una cuenta?', navegacion: 'Iniciar Sesión'),
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

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 30),

      child: Column(
        children: <Widget>[
          
          CustomInput(
            icon: Icons.perm_identity,
            placeholder: 'Nombre',
            textController: nameController,
            keyboardType: TextInputType.text
          ),
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

          // TODO: crear boton
          BotonAzul(
            text: 'Ingresar',
            onPressed: (){
              print('Ingresando');
            }
          ),
          
        ]
      ),
    );
  }
}











