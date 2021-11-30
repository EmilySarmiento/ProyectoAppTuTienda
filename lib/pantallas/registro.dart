import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class registroClientes extends StatefulWidget {
  const registroClientes({Key? key}) : super(key: key);

  @override
  _registroClientesState createState() => _registroClientesState();
}

class _registroClientesState extends State<registroClientes> {
  final cedula = TextEditingController();
  final nombre = TextEditingController();
  final apellidos = TextEditingController();
  final celular = TextEditingController();
  final correo = TextEditingController();
  final direccion = TextEditingController();

  CollectionReference clientes = FirebaseFirestore.instance.collection('clientes'); //conexion a la coleccion de clientes
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registro de clientes"),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children:[
          Container(
            padding: EdgeInsets.all(20),
            child: Text("Ingresa tus datos",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black54,),)
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: TextField(
              autofocus: false,
              keyboardType: TextInputType.phone,
              controller: cedula,
              style: TextStyle(color: Colors.black, fontSize: 15),
              decoration: InputDecoration(
                fillColor: Colors.white70,
                filled: true,
                hintText: "Documento de identificación",
                hintStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black54,),
              ),
            ),
          ),
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
            padding: EdgeInsets.all(30),
            child: ElevatedButton(
              onPressed: (){
                  if(cedula.text.isEmpty || nombre.text.isEmpty || apellidos.text.isEmpty || correo.text.isEmpty || celular.text.isEmpty || direccion.text.isEmpty){
                    print("Campo vacío");
                    showDialog(
                      context: context,
                      builder: (buildcontext)
                    {
                      return AlertDialog(
                        title: Text("Registro fallido", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),),
                        content: Text("Verifica que todos los campos esten llenos"),
                        actions: <Widget>[
                          RaisedButton(
                            child: Text("CERRAR", style: TextStyle(
                                color: Colors.white),),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            color: Colors.redAccent,
                          )
                        ],
                      );
                    },
                    );
                  }else{
                    clientes.doc(cedula.text).set({
                      "nombre":nombre.text,
                      "apellidos" : apellidos.text,
                      "celular" : celular.text,
                      "correo": correo.text,
                      "direccion": direccion.text
                    });
                    showDialog(
                      context: context,
                      builder: (buildcontext)
                      {
                        return AlertDialog(
                          title: Text("Registro exitoso", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),),
                          content: Text("Cliente registrado exitosamente"),
                          actions: <Widget>[
                            RaisedButton(
                              child: Text("CERRAR", style: TextStyle(
                                  color: Colors.white),),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              color: Colors.redAccent,
                            )
                          ],
                        );
                      },
                    );
                  }
              },
              child: Text("Registrar"),
            ),
          ),
        ],
      ),
    );
  }
}
