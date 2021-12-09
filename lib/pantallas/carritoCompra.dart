import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tutienda/main.dart';
import 'package:tutienda/pantallas/pantalla2.dart';
import 'package:tutienda/pantallas/registroPedido.dart';

import 'listaNegocios.dart';

class carritoCompra extends StatefulWidget {
  final List <datosPedido> pedido;
  final String negocio;
  final String cliente;
  const carritoCompra({required this.pedido, required this.negocio, required this.cliente});

  @override
  _carritoCompraState createState() => _carritoCompraState();
}

class _carritoCompraState extends State<carritoCompra> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carrito de compras"),
      ),
      drawer: menuinferior(),
      body: ListView.builder(
          padding: EdgeInsets.all(20),
          itemCount: widget.pedido.length,
          itemBuilder: (BuildContext context,i){
            return ListTile(
              trailing: Icon(Icons.delete,size: 25,color: Colors.redAccent,),
              title: Container(
                padding: EdgeInsets.all(20),
                color: Colors.white70,
                child: Text(widget.pedido[i].nombre+"\nDescripción: "+widget.pedido[i].descripcion+"\nPrecio unitario: "+widget.pedido[i].precio.toString()+"\nCantidad: "+widget.pedido[i].can.toString()+"\nPrecio total: "+widget.pedido[i].total.toString()),
              ),
              onTap: (){
                widget.pedido.removeAt(i);
                setState(() {

                });
              },
            );
          }
      ),
      bottomNavigationBar: confirmar(pedidofinal: widget.pedido, cedula: widget.cliente, idNegocio: widget.negocio,),
    );
  }
}

class confirmar extends StatelessWidget {
  final List<datosPedido> pedidofinal;
  final String cedula;
  final String idNegocio;
  const confirmar({required this.pedidofinal, required this.cedula, required this.idNegocio});

  void registrarDetalle(idPedido){
    CollectionReference detalle = FirebaseFirestore.instance.collection('detallepedido');
    for(int dato=0; dato<pedidofinal.length; dato++){
        detalle.add({
          'pedido': idPedido,
          'producto': pedidofinal[dato].codigo,
          'cantidad': pedidofinal[dato].can,
          'total': pedidofinal[dato].total
        });
    }
  }
  void registrar(){
    DateTime hoy = new DateTime.now();
    DateTime fecha = new DateTime(hoy.year, hoy.month, hoy.day);
    int total=0;
    for(int i=0; i<pedidofinal.length; i++){
      total += pedidofinal[i].total;
    }
    CollectionReference pedido = FirebaseFirestore.instance.collection('pedidos');
    pedido.add({
      'cedula': cedula,
      'negocio': idNegocio,
      'fecha': fecha,
      'total': total
    }).then((value) => registrarDetalle(value.id));
}
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        backgroundColor: Colors.red,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        items:
        [BottomNavigationBarItem(
            icon: Icon(Icons.add_shopping_cart_sharp),
            label: "Agregar Producto",),
          BottomNavigationBarItem(
            icon: Icon(Icons.app_registration),
            label: "Confirmar Pedido",)
        ],
        onTap: (indice){
          if(indice ==0){
            Navigator.pop(context);
          }
          if(indice==1){
            int total=0;
            for(int i=0; i<pedidofinal.length; i++){
                total+= pedidofinal[i].total;
            }
            showDialog(
                context: context,
                builder: (context)=> AlertDialog(
                  title: Text("Confirmar pedido", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent, fontSize: 20),),
                  contentPadding: EdgeInsets.all(20),
                  content: Text("Total a pagar: "+total.toString()),
                  actions: [
                    ElevatedButton(
                        onPressed: (){
                          registrar();
                          Fluttertoast.showToast(msg: "Pedido registrado con éxito.", backgroundColor: Colors.white70, textColor: Colors.black);
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>listaNegocios(cedula: cedula)));
                        }, child: Text("CONFIRMAR")),
                    ElevatedButton(
                        onPressed: (){
                          Navigator.of(context).pop();
                        }, child: Text("CANCELAR"))
                  ],
                ));
          }
    },
    );
  }
}


