import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tutienda/pantallas/negocios.dart';
import 'package:tutienda/pantallas/pantalla2.dart';

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
        body: Center(
          child: ListView.builder(
            itemCount: tabla_productos.length,
            itemBuilder: (BuildContext context,i){
              return ListTile(
                title: Text("producto "+i.toString()+" - "+tabla_productos[i]['nombre'].toString()),

              );
            },
          ),
        ),
        bottomNavigationBar : menuinferior()
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