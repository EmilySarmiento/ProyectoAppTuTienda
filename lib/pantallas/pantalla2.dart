import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tutienda/pantallas/negocios.dart';
import 'package:tutienda/pantallas/pantalla3.dart';
import 'package:tutienda/pantallas/pantalla4.dart';
import 'package:tutienda/pantallas/productos.dart';

class pantalla2 extends StatelessWidget {

  TextEditingController dato = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          automaticallyImplyLeading: false,
        ),
        body: Container(
          padding: EdgeInsets.all(40),
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.all(20),
                  child: Text("¿Qué deseas buscar?",style: TextStyle(color: Colors.redAccent, fontSize: 24, fontWeight: FontWeight.bold,),),),
              Container(
                  margin: EdgeInsets.all(10),
                  child: TextField(
                    controller: dato,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search, color : Colors.redAccent, size: 25,),
                        hintText: "Ej.: salud, comidas, belleza ...",
                    ),
                  ),
                ),

                Container(
                  padding: EdgeInsets.all(0),
                  child: ElevatedButton(
                    onPressed: (){
                      print(dato.text);
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>pantalla3(dato.text)));
                    },
                    child: Text("Buscar por categoría"),

                  ),
                ),
                Container(
                padding: EdgeInsets.all(0),
                child: ElevatedButton(
                  onPressed: (){
                    print(dato.text);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>pantalla4(dato.text)));
                  },
                  child: Text("Buscar por producto"),

                ),
              ),
              ],
            ),
          ),

        floatingActionButton: FloatingActionButton(
          onPressed: (){
          },
          child: Icon(Icons.accessibility),
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





