import 'package:flutter/material.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tutienda/pantallas/pantalla2.dart';
import 'package:tutienda/pantallas/productos.dart';

class negocio extends StatefulWidget {
  const negocio({Key? key}) : super(key: key);
  @override
  _negocioState createState() => _negocioState();
}

class _negocioState extends State<negocio> {
  List tabla_negocios= [];

  void initState(){
    super.initState();
    getNegocios();
  }
  void getNegocios() async { //Función para consultar negocios
    CollectionReference datos = FirebaseFirestore.instance.collection('negocios');
    QuerySnapshot negocios = await datos.get();
    if (negocios.docs.length >0){
      print("trae datos");
      for (var doc in negocios.docs){
        print(doc.data());
        setState(() {
          tabla_negocios.add(doc.data());
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
          title: Text("Negocios"),
        ),
        body: Center(
          child: ListView.builder(
            itemCount: tabla_negocios.length,
            itemBuilder: (BuildContext context,i){
              return ListTile(
                title: Text("Negocio "+i.toString()+" - "+tabla_negocios[i]['nombre'].toString()),

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





