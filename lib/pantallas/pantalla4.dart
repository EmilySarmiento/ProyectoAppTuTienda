import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tutienda/pantallas/pantalla2.dart';
import 'package:tutienda/pantallas/productos.dart';
import 'package:tutienda/pantallas/vistaproducto.dart';

class pantalla4 extends StatefulWidget {
  final String criterio;
  const pantalla4(this.criterio, {Key? key}) : super(key: key);

  @override
  _pantalla4State createState() => _pantalla4State();
}

class _pantalla4State extends State<pantalla4> {
  List listaProductos=[];
  List listaNegocios=[];
  void initState(){
    super.initState();
    getProducto();
  }
  void getProducto() async {
    CollectionReference productos = FirebaseFirestore.instance.collection('productos');
    QuerySnapshot res = await productos.where('nombre',isEqualTo: widget.criterio).get();
    if (res.docs != 0){
      print("trae datos");
      for(var neg in res.docs){
        print(neg.data());
        setState(() {
          listaProductos.add(neg.data());
        });
      }
    }else{
      print("Algo falló");
    }
    //Consulta negocios
    String id;
    CollectionReference datos2 = FirebaseFirestore.instance.collection('negocios');
    for(var i=0 ; i<listaNegocios.length; i++){
        id=listaNegocios[i]['negocios'];
        print(id);
        QuerySnapshot negocio = await datos2.where(FieldPath.documentId, isEqualTo: id).get();
        if(negocio.docs.length!=0){
          for(var neg in negocio.docs){
            print(neg.data());
            listaNegocios.add(neg.data());
          }
        }else{
          print("No hay negocios");
        }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Búsqueda"),
        ),
      drawer: menuinferior(),
      body: Center(
          child: ListView.builder(
            padding: EdgeInsets.all(15),
            itemCount: listaProductos.length,
            itemBuilder: (BuildContext,i){
              return ListTile(
                onTap: (){
                  print(listaProductos[i]);
                  datosProductos n = datosProductos(listaProductos[i]['nombre'], listaProductos[i]['precio'], listaProductos[i]['descripcion'], listaProductos[i]['negocio'],listaProductos[i]['foto']);
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>vistaproducto(tienda: n)));
                },
                title: myCardImage(url: listaProductos[i]['foto'],texto: listaProductos[i]['nombre']+"\n"+listaProductos[i]['precio'].toString(), texto2:listaProductos[i]['descripcion'], ),
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
