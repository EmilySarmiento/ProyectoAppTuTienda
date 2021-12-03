import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tutienda/pantallas/pantalla2.dart';
import 'package:tutienda/pantallas/productos.dart';

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
                child: Text("Descripción:\n"+tienda.descripcion,style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold, color: Colors.black54),)
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
