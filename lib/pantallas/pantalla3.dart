import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tutienda/pantallas/negocios.dart';
import 'package:tutienda/pantallas/pantalla2.dart';
import 'package:tutienda/pantallas/vistanegocio.dart';

class pantalla3 extends StatefulWidget {
  final String criterio;
  const pantalla3(this.criterio, {Key? key}) : super(key: key);

  @override
  _pantalla3State createState() => _pantalla3State();
}

class _pantalla3State extends State<pantalla3> {
  List listaNegocios=[];
  void initState(){
    super.initState();
    getNegocio();
  }
  void getNegocio() async {
    CollectionReference negocios = FirebaseFirestore.instance.collection('negocios');
    QuerySnapshot res = await negocios.where('categoria',isEqualTo: widget.criterio).get();
    if (res.docs != 0){
      print("trae datos");
      for(var neg in res.docs){
        print(neg.data());
        setState(() {
          listaNegocios.add(neg.data());
        });
      }
    }else{
      print("Algo falló");
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Búsqueda"),
      ),
      drawer: menuinferior(),
      body: ListView.builder(
            padding: EdgeInsets.all(15),
            itemCount: listaNegocios.length,
            itemBuilder: (BuildContext,i){
              return ListTile(
                onTap: (){
                  print(listaNegocios[i]);
                  datosNegocios d = datosNegocios(listaNegocios[i]['nombre'], listaNegocios[i]['celular'], listaNegocios[i]['telefono'], listaNegocios[i]['direccion'], listaNegocios[i]['paginaweb'], listaNegocios[i]['foto']);
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>vistanegocio(tienda: d)));
                  },
                title: myCardImage(url: listaNegocios[i]['logo'],texto: listaNegocios[i]['nombre']+"\n"+listaNegocios[i]['celular'].toString(),texto2: listaNegocios[i]['direccion'], ),
                );
              },
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


