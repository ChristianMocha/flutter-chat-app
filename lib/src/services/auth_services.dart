import 'dart:convert';
import 'dart:ffi';

import 'package:chat/global/enviroment.dart';
import 'package:chat/src/models/login_response.dart';
import 'package:chat/src/models/user.response.dart';
import 'package:chat/src/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService with ChangeNotifier{

  Usuario? usuario;
  bool _autenticando = false;

  // Create storage
  final _storage = new FlutterSecureStorage();

  bool get autenticando => this._autenticando;
  set autenticando(bool value){
    this._autenticando = value;
    notifyListeners();
  }

  static Future<String> getToken() async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token.toString();
  }
  static Future<void> eliminarToken() async {
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  Future<bool> login(String email, String password) async {
    this.autenticando = true;

    final data = {
      'email': email,
      'password': password
    };

    final resp = await http.post(Uri.parse('${ Enviroment.apiUrl }/login'), 
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json'
      }
    );

    this.autenticando = false;

    if ( resp.statusCode == 200 ) {
      final loginResponse = loginResponseFromJson(resp.body);
      usuario = loginResponse.usuario;
      await this._guardarToken(loginResponse.token.toString());
      return true;
    } else {
      return false;
    }
  }

  Future register( String nombre, String email, String password) async {

    this.autenticando = true;

    final data = {
      'nombre': nombre,
      'email': email,
      'password': password
    };

    final resp = await http.post(Uri.parse('${ Enviroment.apiUrl }/login/new'), 
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json'
      }
    );

    this.autenticando = false;

    if ( resp.statusCode == 200 ) {
      final registerResponse = registerUserFromJson(resp.body);
      usuario = registerResponse.usuario;
      await this._guardarToken(registerResponse.token.toString());
      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await this._storage.read(key: 'token');
    final resp = await http.get(Uri.parse('${ Enviroment.apiUrl }/login/renew'), 
      headers: {
        'Content-Type': 'application/json',
        'x-token': token.toString()
      }
    );

    if ( resp.statusCode == 200 ) {
      final registerResponse = registerUserFromJson(resp.body);
      usuario = registerResponse.usuario;
      await this._guardarToken(registerResponse.token.toString());
      return true;
    } else {
      this.logout();
      return false;
    }
  }

  Future _guardarToken( String token ) async{
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async{
    await _storage.delete(key: 'token');
  }
  
}