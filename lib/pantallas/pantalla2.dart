import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tutienda/pantallas/comprobarCliente.dart';
import 'package:tutienda/pantallas/mensaje.dart';
import 'package:tutienda/pantallas/negocios.dart';
import 'package:tutienda/pantallas/pantalla3.dart';
import 'package:tutienda/pantallas/pantalla4.dart';
import 'package:tutienda/pantallas/pedidos.dart';
import 'package:tutienda/pantallas/perfilCliente.dart';
import 'package:tutienda/pantallas/productos.dart';
import 'package:tutienda/pantallas/registro.dart';

import '../main.dart';

class pantalla2 extends StatelessWidget {

  TextEditingController dato = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Inicio"),
        ),
        drawer: menuinferior(),
        body: Container(
          padding: EdgeInsets.all(40),
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.all(20),
                  child: Text("¿Qué deseas buscar?",style: TextStyle(color: Colors.redAccent, fontSize: 24, fontWeight: FontWeight.bold,),),),
              Container(
                  margin: EdgeInsets.all(10),
                  child: TextField(
                    controller: dato,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search, color : Colors.redAccent, size: 25,),
                        hintText: "Ej.: salud, comidas, belleza ...",
                    ),
                  ),
                ),

                Container(
                  padding: EdgeInsets.all(0),
                  child: ElevatedButton(
                    onPressed: (){
                      print(dato.text);
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>pantalla3(dato.text)));
                    },
                    child: Text("Buscar por categoría"),

                  ),
                ),
                Container(
                padding: EdgeInsets.all(0),
                child: ElevatedButton(
                  onPressed: (){
                    print(dato.text);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>pantalla4(dato.text)));
                  },
                  child: Text("Buscar por producto"),

                ),
              ),
              ],
            ),
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
                leading: Icon(Icons.add_alert_sharp),
                title: Text("Notificaciones"),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>mensaje()));
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



