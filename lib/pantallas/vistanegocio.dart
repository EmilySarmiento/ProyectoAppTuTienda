import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tutienda/pantallas/pantalla2.dart';
import 'package:url_launcher/url_launcher.dart';
import 'negocios.dart';

class vistanegocio extends StatelessWidget {
  final datosNegocios tienda;
  const vistanegocio({required this.tienda});

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
          myCardImage(url: tienda.foto,texto: tienda.nombre+"\n"+tienda.celular.toString()),
          Container(
              padding: EdgeInsets.all(0),
              child: Text("Dirección:\n"+tienda.direccion +"\n"+"Telefono/Celular:\n"+tienda.telefono.toString(),style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold, color: Colors.black54),)
          ),
          ElevatedButton(
              onPressed: (){
                launch(tienda.paginaweb);
              }, child: Text("Ir a página web")),
          ElevatedButton(
              onPressed: (){
                launch(tienda.geolocalizacion);
                }, child: Text("Ir a geolocalización"))
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


