import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tutienda/pantallas/listaNegocios.dart';
import 'package:tutienda/pantallas/pantalla2.dart';


class pedidos extends StatefulWidget {
  const pedidos({Key? key}) : super(key: key);

  @override
  _pedidosState createState() => _pedidosState();
}
class _pedidosState extends State<pedidos> {

  final ingreso = TextEditingController();
  final ingreso2 = TextEditingController();
  CollectionReference clientes = FirebaseFirestore.instance.collection('clientes'); //conexion a la coleccion de clientes

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pedidos"),
      ),
      drawer: menuinferior(),
      body: Container(
        padding: EdgeInsets.all(20),
        color: Colors.white60,
        child: Center(
            child: ListView(
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  child:Center(
                    child: Text("Autenticación cliente",style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black54)),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    autofocus: false,
                    controller: ingreso,
                    keyboardType: TextInputType.phone, //coloca el tipo de teclado que se va a mostrar, en este caso el numérico
                    textInputAction: TextInputAction.send, // en enviar, cambia el enter por e avion
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.assignment_ind_sharp, color : Colors.redAccent, size: 25,),
                      hintText: "Ingresa tu número de cédula",
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    autofocus: false,
                    controller: ingreso2,
                    keyboardType: TextInputType.text, //coloca el tipo de teclado que se va a mostrar, en este caso el numérico
                    textInputAction: TextInputAction.send, // en enviar, cambia el enter por e avion
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.mail, color : Colors.redAccent, size: 25,),
                      hintText: "Ingresa tu correo electrónico",
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  child: ElevatedButton(
                    onPressed: () async {
                      QuerySnapshot existe = await clientes.where(
                          FieldPath.documentId, isEqualTo: ingreso.text).where('correo', isEqualTo: ingreso2.text).get();
                      List lista=[];
                      if (existe.docs.length > 0) {
                        for (var cli in existe.docs){
                          lista.add(cli.data());
                        }
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>listaNegocios(cedula: ingreso.text))); //Dirigir con el botón a otra pantalla

                      }else{
                        showDialog(
                          context: context,
                          builder: (buildcontext) {
                            return AlertDialog(
                              title: Text("Ingreso fallido", style: TextStyle(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.bold),),
                              content: Text("Cédula o correo electrónico incorrecto"),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Ingresar"),
                      ],
                    ),
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }
}

