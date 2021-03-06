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
          padding: EdgeInsets.all(20),
          color: Colors.white60,
          child: Center(
              child: ListView(
                children: [
                  Container(
                      padding: EdgeInsets.all(0),
                      child: Image.network('https://blogger.googleusercontent.com/img/a/AVvXsEjDi_BXcRzjR5XNluGnTil5ajE-RYBkVjewgnlJ5ViBQidONlCA-iHKEifMi8sx4ZHJV2NWrRVeg4mIe6KJjVtM-Lc-TKs0pUmveLD_8B4QKPw8N6Iq4YNXmOYaB4O4OsHoPdUdguW_2grU_9viTPH6t8l3XTS7HzfYdqlK_lGVtqQs9tdVPG6VVk72iA=s320',scale:2,)),
                  Container(
                    padding: EdgeInsets.all(5),
                    child:Center(
                      child: Text("Bienvenido a TuTienda",style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black54)),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      autofocus: false,
                      controller: ingreso,
                      keyboardType: TextInputType.phone, //coloca el tipo de teclado que se va a mostrar, en este caso el num??rico
                      textInputAction: TextInputAction.send, // en enviar, cambia el enter por e avion
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.assignment_ind_sharp, color : Colors.redAccent, size: 25,),
                        hintText: "Ingresa tu n??mero de c??dula",
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      autofocus: false,
                      controller: ingreso2,
                      keyboardType: TextInputType.text, //coloca el tipo de teclado que se va a mostrar, en este caso el num??rico
                      textInputAction: TextInputAction.send, // en enviar, cambia el enter por e avion
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.mail, color : Colors.redAccent, size: 25,),
                        hintText: "Ingresa tu correo electr??nico",
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
                            datosCliente dCli = datosCliente(ingreso.text, lista[0]['nombre'], lista[0]['apellidos'], lista[0]['celular'], lista[0]['correo'], lista[0]['direccion']);
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>pantalla2())); //Dirigir con el bot??n a otra pantalla

                          }else{
                            showDialog(
                              context: context,
                              builder: (buildcontext) {
                                return AlertDialog(
                                  title: Text("Ingreso fallido", style: TextStyle(
                                      color: Colors.redAccent,
                                      fontWeight: FontWeight.bold),),
                                  content: Text("C??dula o correo electr??nico incorrecto"),
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
                          Text("Iniciar sesi??n"),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    child: ElevatedButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>registroClientes())); //Dirigir con el bot??n a otra pantalla
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Reg??strate"),
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

class datosCliente{
  String cedula="";
  String nombre="";
  String apellidos="";
  String celular="";
  String correo="";
  String direccion="";

  datosCliente(this.cedula, this.nombre,this.apellidos, this.celular, this.correo, this.direccion );
}