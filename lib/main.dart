import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tutienda/pantallas/pantalla2.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tutienda/pantallas/perfilCliente.dart';
import 'package:tutienda/pantallas/registro.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((value) {
    runApp(const principal());
  });
}

class principal extends StatelessWidget {
  const principal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "TuTienda",
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: miTienda()
    );
  }
}
class miTienda extends StatefulWidget {
  const miTienda({Key? key}) : super(key: key);

  @override
  _miTiendaState createState() => _miTiendaState();
}
class _miTiendaState extends State<miTienda> {

  final ingreso = TextEditingController();
  final ingreso2 = TextEditingController();
  CollectionReference clientes = FirebaseFirestore.instance.collection('clientes'); //conexion a la coleccion de clientes

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("TuTienda"),
        ),
        body: Container(
          color: Colors.white60,
          child: Center(
              child: ListView(
                children: [
                  Container(
                      padding: EdgeInsets.all(10),
                      child: Image.network('https://lh3.googleusercontent.com/-YK9Sy-RAGus/YZw1A29ncjI/AAAAAAAABSo/WRyxIqljZvAPXeoK1z6thebDAd3gkwD0QCLcBGAsYHQ/image.png')),
                  Container(
                    padding: EdgeInsets.all(10),
                    child:Center(
                      child: Text("Bienvenido a TuTienda",style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black54)),
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
                          if (existe.docs.length > 0) {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>actualizarCliente())); //Dirigir con el botón a otra pantalla

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
                          Text("Iniciar sesión"),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    child: ElevatedButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>registroClientes())); //Dirigir con el botón a otra pantalla
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Regístrate"),
                        ],
                      ),
                    ),
                  ),
                ],
              )
          ),
        )
    );
  }
}

