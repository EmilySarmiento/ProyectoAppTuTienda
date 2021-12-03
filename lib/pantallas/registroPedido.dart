import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tutienda/pantallas/pantalla2.dart';

class registrarPedido extends StatefulWidget {
  final String id, cedula;

  const registrarPedido({required this.id, required this.cedula});

  @override
  _registrarPedidoState createState() => _registrarPedidoState();
}

class _registrarPedidoState extends State<registrarPedido> {
  
  List productos = [];
  List codigoProductos = [];
  List <datosPedido> nombrePedido = [];
  void initState(){
    super.initState();
    getProducto();
  }
  void getProducto() async {
    CollectionReference pro = FirebaseFirestore.instance.collection('productos');
    String cod="";
    QuerySnapshot datos = await pro.where('negocio', isEqualTo : widget.id).get();
    if(datos.docs.length > 0){
      for(var doc in datos.docs){
        productos.add(doc.data());
        cod = doc.id.toString();
        codigoProductos.add(cod);
      }
    }
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Registrar pedido"),
          actions: [
            IconButton(
                onPressed: (){
                  print(nombrePedido[0].nombre);
                  print(nombrePedido[0].total);
                }, icon: Icon(Icons.shopping_cart,size: 25,))
          ],
      ),
      drawer: menuinferior(),
      body: ListView.builder(
          padding: EdgeInsets.all(20),
          itemCount: productos.length,
          itemBuilder: (BuildContext context,i){
            var can = TextEditingController();
            return ListTile(
              leading: Icon(Icons.add_circle,size: 25,color: Colors.redAccent,),
              title: Container(
                padding: EdgeInsets.all(20),
                color: Colors.white70,
                child: Text(productos[i]['nombre']+"\n"+productos[i]['descripcion']+"\n"+productos[i]['precio'].toString()),
              ),
              subtitle: TextField(
                controller: can,
                decoration: InputDecoration(hintText: "Cant. ",),
                keyboardType: TextInputType.number,
              ),
              onTap: (){
                if(can.text.isEmpty){
                  can.text="0";
                }
                int total=int.parse(can.text)*(int.parse(productos[i]['precio'].toString()));
                print(total.toString());
                datosPedido p = datosPedido(codigoProductos[i], productos[i]['nombre'], productos[i]['descripcion'], productos[i]['precio'], int.parse(can.text), total);
                nombrePedido.add(p);
              },
            );
          }
      ),
    );
  }
}

class datosPedido{
  String codigo="";
  String nombre="";
  String descripcion="";
  int precio=0;
  int can=0;
  int total=0;

  datosPedido(this.codigo, this.nombre, this.descripcion, this.precio, this.can, this.total);
}
