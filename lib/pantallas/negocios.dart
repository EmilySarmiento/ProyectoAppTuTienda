import 'package:flutter/material.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tutienda/main.dart';
import 'package:tutienda/pantallas/comprobarCliente.dart';
import 'package:tutienda/pantallas/pantalla2.dart';
import 'package:tutienda/pantallas/pedidos.dart';
import 'package:tutienda/pantallas/productos.dart';
import 'package:tutienda/pantallas/vistanegocio.dart';

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
        drawer: menuinferior(),
        body: Center(
          child: ListView.builder(
            padding: EdgeInsets.all(15),
            itemCount: tabla_negocios.length,
            itemBuilder: (BuildContext,i){
              return ListTile(
                onTap: (){
                  print(tabla_negocios[i]);
                  datosNegocios n = datosNegocios(tabla_negocios[i]['nombre'], tabla_negocios[i]['celular'], tabla_negocios[i]['telefono'], tabla_negocios[i]['direccion'], tabla_negocios[i]['paginaweb'], tabla_negocios[i]['foto'],tabla_negocios[i]['geolocalizacion']);
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>vistanegocio(tienda: n)));
                  },
                title: myCardImage(url: tabla_negocios[i]['logo'],texto: tabla_negocios[i]['nombre']+"\n"+tabla_negocios[i]['celular'].toString(),texto2: tabla_negocios[i]['direccion'], ),
              );
            },
          ),
        ),
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

class datosNegocios{
  String nombre="";
  int celular =0;
  int telefono=0;
  String direccion="";
  String paginaweb="";
  String foto="";
  String geolocalizacion="";

  datosNegocios(this.nombre, this.celular, this.telefono, this.direccion, this.paginaweb, this.foto, this.geolocalizacion);
}
