import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tutienda/main.dart';
import 'package:tutienda/pantallas/comprobarCliente.dart';
import 'package:tutienda/pantallas/negocios.dart';
import 'package:tutienda/pantallas/pantalla2.dart';
import 'package:tutienda/pantallas/pedidos.dart';
import 'package:tutienda/pantallas/vistaproducto.dart';

class productos extends StatefulWidget {
  const productos({Key? key}) : super(key: key);
  @override
  _productosState createState() => _productosState();
}

class _productosState extends State<productos> {
  List tabla_productos= [];

  void initState(){
    super.initState();
    getProductos();
  }
  void getProductos() async { //Función para consultar productos
    CollectionReference datos = FirebaseFirestore.instance.collection('productos');
    QuerySnapshot productos = await datos.get();
    if (productos.docs.length >0){
      print("trae datos");
      for (var doc in productos.docs){
        print(doc.data());
        setState(() {
          tabla_productos.add(doc.data());
        });
      }
    }else{
      print("fallo");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Productos"),
        ),
        drawer: menuinferior(),
        body: Center(
          child: ListView.builder(
            padding: EdgeInsets.all(15),
            itemCount: tabla_productos.length,
            itemBuilder: (BuildContext,i){
              return ListTile(
                onTap: (){
                  print(tabla_productos[i]);
                  datosProductos n = datosProductos(tabla_productos[i]['nombre'], tabla_productos[i]['precio'], tabla_productos[i]['descripcion'], tabla_productos[i]['negocio'],tabla_productos[i]['foto']);
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>vistaproducto(tienda: n)));
                  },
                title: myCardImage(url: tabla_productos[i]['foto'],texto: tabla_productos[i]['nombre']+"\n"+tabla_productos[i]['precio'].toString(), texto2:tabla_productos[i]['descripcion'], ),
              );
            },
          ),
        ),
    );
  }
}

class datosProductos{
  String nombre="";
  int precio =0;
  String descripcion="";
  String negocio="";
  String foto="";

  datosProductos(this.nombre, this.precio, this.descripcion, this.negocio, this.foto);
}

class myCardImage extends StatelessWidget {
  final String url;
  final String texto;
  final String texto2;
  const myCardImage({required this.url, required this.texto, required this.texto2});


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
              Container(
                padding: EdgeInsets.all(15),
                child: Text(texto2),
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



