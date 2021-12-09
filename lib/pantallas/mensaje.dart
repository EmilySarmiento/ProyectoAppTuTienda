import 'package:flutter/material.dart';
import 'package:tutienda/pantallas/pantalla2.dart';
import 'notificaciones.dart';
class mensaje extends StatefulWidget {
  const mensaje({Key? key}) : super(key: key);

  @override
  _mensajeState createState() => _mensajeState();
}

class _mensajeState extends State<mensaje> {

  void initState(){
    super.initState();
    final notificaciones mensaje = new notificaciones();
    mensaje.generarToken();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notificaciones"),
      ),
      drawer: menuinferior(),
    );
  }
}
