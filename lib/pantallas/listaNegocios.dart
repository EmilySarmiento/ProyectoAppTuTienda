import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tutienda/pantallas/pantalla2.dart';
import 'package:tutienda/pantallas/registroPedido.dart';


class listaNegocios extends StatefulWidget {
  final String cedula;
  const listaNegocios({required this.cedula});

  @override
  _listaNegociosState createState() => _listaNegociosState();
}

class _listaNegociosState extends State<listaNegocios> {
  List lista=[];
  List codigos=[];
  void initState(){
    super.initState();
    getNegocio();
  }
  void getNegocio() async {
    CollectionReference negocio = FirebaseFirestore.instance.collection('negocios');
    QuerySnapshot dato = await negocio.get();
    String id="";
    if(dato.docs.length > 0){
      for(var n in dato.docs){
        lista.add(n.data());
        id = n.id.toString();
        codigos.add(id);
      }
    }
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Listado negocios"),
      ),
      drawer: menuinferior(),
      body: Center(
        child: ListView.builder(
            itemCount: lista.length,
            itemBuilder: (BuildContext context, i){
              return ListTile(
                title: myCardImage(url: lista[i]['logo'],texto: lista[i]['nombre']+"\n"+lista[i]['celular'].toString(),texto2: lista[i]['direccion'], ),
              onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>registrarPedido(id: codigos[i], cedula: widget.cedula)));
              },
              );
            }
        ),
      )
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

