import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tutienda/pantallas/comprobarCliente.dart';

class listaNegocios extends StatefulWidget {
  final String cedula;
  const listaNegocios({required this.cedula});

  @override
  _listaNegociosState createState() => _listaNegociosState();
}

class _listaNegociosState extends State<listaNegocios> {

  void getNegocio() async {
    CollectionReference negocio = FirebaseFirestore.instance.collection('negocios');
    QuerySnapshot dato = await negocio.get();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Listado negocios"),
      ),
      drawer: menuinferior(),
      body: Text(
        "cliente: "+widget.cedula
      ),
    );
  }
}
