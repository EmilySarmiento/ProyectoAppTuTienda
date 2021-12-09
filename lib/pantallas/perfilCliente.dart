import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tutienda/pantallas/pantalla2.dart';
import '../main.dart';
import 'comprobarCliente.dart';

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
                        Navigator.of(context).pop();
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



