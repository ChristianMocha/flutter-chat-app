
import 'package:flutter/material.dart';

import 'package:chat/src/pages/chat_page.dart';
import 'package:chat/src/pages/loading_page.dart';
import 'package:chat/src/pages/login_page.dart';
import 'package:chat/src/pages/register_page.dart';
import 'package:chat/src/pages/usuarios_page.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {

  'usuarios': (_) => UsuariosPage(),
  'login': (_) => LoginPage(),
  'chat': (_) => ChatPage(),
  'loading': (_) => LoadingPage(),
  'register': (_) => RegisterPage(),

};