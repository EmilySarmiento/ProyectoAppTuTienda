import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tutienda/pantallas/pantalla2.dart';
import 'package:tutienda/pantallas/pedidos.dart';

import '../main.dart';
import 'comprobarCliente.dart';
import 'negocios.dart';
import 'productos.dart';

class actualizarCliente extends StatefulWidget {
  final datosClientes cliente;
  const actualizarCliente({required this.cliente});

  @override
  _actualizarClienteState createState() => _actualizarClienteState();
}

class _actualizarClienteState extends State<actualizarCliente> {
  final nombre = TextEditingController();
  final apellidos = TextEditingController();
  final celular = TextEditingController();
  final correo = TextEditingController();
  final direccion = TextEditingController();
  @override
  Widget build(BuildContext context) {
    nombre.text = widget.cliente.nombre;
    apellidos.text = widget.cliente.apellidos;
    celular.text = widget.cliente.celular;
    correo.text = widget.cliente.correo;
    direccion.text = widget.cliente.direccion;
    return Scaffold(
        appBar: AppBar(
          title: Text("Perfil: "+widget.cliente.nombre+" "+widget.cliente.apellidos),
        ),
        drawer: menuinferior(),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: TextField(
                autofocus: false,
                controller: nombre,
                style: TextStyle(color: Colors.black, fontSize: 15),
                decoration: InputDecoration(
                  fillColor: Colors.white70,
                  filled: true,
                  hintText: "Nombre",
                  hintStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black54,),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: TextField(
                autofocus: false,
                controller: apellidos,
                style: TextStyle(color: Colors.black, fontSize: 15),
                decoration: InputDecoration(
                  fillColor: Colors.white70,
                  filled: true,
                  hintText: "Apellidos",
                  hintStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black54,),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: TextField(
                autofocus: false,
                keyboardType: TextInputType.phone,
                controller: celular,
                style: TextStyle(color: Colors.black, fontSize: 15),
                decoration: InputDecoration(
                  fillColor: Colors.white70,
                  filled: true,
                  hintText: "Celular",
                  hintStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black54,),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: TextField(
                autofocus: false,
                controller: correo,
                style: TextStyle(color: Colors.black, fontSize: 15),
                decoration: InputDecoration(
                  fillColor: Colors.white70,
                  filled: true,
                  hintText: "Correo electrónico",
                  hintStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black54,),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: TextField(
                autofocus: false,
                controller: direccion,
                style: TextStyle(color: Colors.black, fontSize: 15),
                decoration: InputDecoration(
                  fillColor: Colors.white70,
                  filled: true,
                  hintText: "Dirección",
                  hintStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black54,),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: ElevatedButton(
                      onPressed: (){
                          if(nombre.text.isEmpty || apellidos.text.isEmpty || celular.text.isEmpty || correo.text.isEmpty || direccion.text.isEmpty){
                            showDialog(
                              context: context,
                              builder: (buildcontext) {
                                return AlertDialog(
                                  title: Text("Actualización fallida", style: TextStyle(
                                      color: Colors.redAccent,
                                      fontWeight: FontWeight.bold),),
                                  content: Text(
                                      "Verifica que todos los campos esten llenos"),
                                  actions: <Widget>[
                                    ElevatedButton(
                                      child: Text("CERRAR", style: TextStyle(
                                          color: Colors.white),),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    )
                                  ],
                                );
                              },
                            );
                          }else{
                            CollectionReference actualiza = FirebaseFirestore.instance.collection('clientes');
                            actualiza.doc(widget.cliente.cedula).update({
                              "nombre": nombre.text,
                              "apellidos": apellidos.text,
                              "celular": celular.text,
                              "correo": correo.text,
                              "direccion": direccion.text
                            });
                            showDialog(
                              context: context,
                              builder: (buildcontext) {
                                return AlertDialog(
                                  title: Text("Actualización exitosa", style: TextStyle(
                                      color: Colors.redAccent,
                                      fontWeight: FontWeight.bold),),
                                  content: Text(
                                      "Datos actualizados satisfactoriamente"),
                                  actions: <Widget>[
                                    ElevatedButton(
                                      child: Text("CERRAR", style: TextStyle(
                                          color: Colors.white),),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    )
                                  ],
                                );
                              },
                            );
                          }
                      },
                      child: Text("Actualizar"),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: ElevatedButton(
                      onPressed: (){
                        CollectionReference elimina = FirebaseFirestore.instance.collection('clientes');
                        elimina.doc(widget.cliente.cedula).delete();

                        showDialog(
                          context: context,
                          builder: (buildcontext) {
                            return AlertDialog(
                              title: Text("Eliminación exitosa", style: TextStyle(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.bold),),
                              content: Text(
                                  "Cliente eliminado satisfactoriamente"),
                              actions: <Widget>[
                                ElevatedButton(
                                  child: Text("CERRAR", style: TextStyle(
                                      color: Colors.white),),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            );
                          },
                        );
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>principal()));
                      },
                      child: Text("Eliminar"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
    );
  }
}

class menuinferior extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(0),
        children: [
          DrawerHeader(
              decoration: BoxDecoration(color: Colors.redAccent),
              child: Image.network("https://i.pinimg.com/564x/9e/cd/a5/9ecda51d8c2bad23237e6e63159df01b.jpg", scale: 0.5)),
          Column(
            children: [
              ListTile(
                leading: Icon(Icons.home),
                title: Text("Inicio"),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>pantalla2()));
                },
              ),
              ListTile(
                leading: Icon(Icons.business_center_sharp),
                title: Text("Negocios"),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>negocio()));
                },
              ),
              ListTile(
                leading: Icon(Icons.emoji_food_beverage),
                title: Text("Productos"),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>productos()));
                },
              ),
              ListTile(
                leading: Icon(Icons.accessibility),
                title: Text("Cliente"),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>comprobarCliente()));
                },
              ),
              ListTile(
                leading: Icon(Icons.assignment_turned_in),
                title: Text("Pedidos"),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>pedidos()));
                },
              ),
              ListTile(
                leading: Icon(Icons.close),
                title: Text("Cerrar sesión"),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>principal()));
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}


