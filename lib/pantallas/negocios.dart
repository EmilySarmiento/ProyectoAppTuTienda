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
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: ListView.builder(
            padding: EdgeInsets.all(15),
            itemCount: tabla_negocios.length,
            itemBuilder: (BuildContext,i){
              return Container(
                child: myCardImage(url: tabla_negocios[i]['logo'],texto: tabla_negocios[i]['nombre']+"\n"+tabla_negocios[i]['celular'].toString(),texto2: tabla_negocios[i]['direccion'], ),
              );
            },
          ),
        ),
        bottomNavigationBar : menuinferior()
    );
  }
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





