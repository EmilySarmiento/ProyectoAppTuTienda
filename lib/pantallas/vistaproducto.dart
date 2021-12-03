import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tutienda/pantallas/pantalla2.dart';
import 'package:tutienda/pantallas/pedidos.dart';
import 'package:tutienda/pantallas/productos.dart';
import 'package:url_launcher/url_launcher.dart';
import '../main.dart';
import 'comprobarCliente.dart';
import 'negocios.dart';

class vistaproducto extends StatelessWidget {
  final datosProductos tienda;
  const vistaproducto({required this.tienda});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(tienda.nombre)
        ),
        drawer: menuinferior(),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            myCardImage(url: tienda.foto,texto: tienda.nombre+"\n"+tienda.precio.toString()),
            Container(
                padding: EdgeInsets.all(0),
                child: Text("Descripción:\n"+tienda.descripcion+"\nNegocio:\n"+tienda.negocio,style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold, color: Colors.black54),)
            ),
          ],
        ),
    );
  }
}

class myCardImage extends StatelessWidget {
  final String url;
  final String texto;
  const myCardImage({required this.url, required this.texto});


  @override
  Widget build(BuildContext context) {
    return Card(
      shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin:EdgeInsets.all(20),
      elevation:5,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Column(
            children: [
              Image.network(url),
              Container(
                padding: EdgeInsets.all(10),
                child: Text(texto
                  , style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 20), textAlign: TextAlign.center,),
              ),
            ]
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



