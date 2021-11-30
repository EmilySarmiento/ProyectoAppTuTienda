import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tutienda/pantallas/pantalla2.dart';
import 'package:tutienda/pantallas/productos.dart';
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
              }, child: Text("Ir a página web"))
        ],
      ),
        bottomNavigationBar : menuinferior()
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
    return BottomNavigationBar(
        backgroundColor: Colors.red,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        onTap: (index){
          if(index ==0){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>pantalla2()));
          }else if(index==1){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>negocio()));
          }else{
            Navigator.push(context, MaterialPageRoute(builder: (context)=>productos()));
          }
        },
        items: [
          BottomNavigationBarItem(
              icon : Icon(Icons.account_box),
              label: "Home"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.business_center_sharp),
              label: "Negocios"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.emoji_food_beverage),
              label:"Productos"
          ),
        ]
    );
  }
}

