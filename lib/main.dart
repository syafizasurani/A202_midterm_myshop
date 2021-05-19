import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'newproduct.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: MyShop(),
    );
  }
}

class MyShop extends StatefulWidget {
  @override
  _MyShopState createState() => _MyShopState();
}

class _MyShopState extends State<MyShop> {
  double screenHeight;
  double screenWidth;
  List productlist;
  String _titlecenter = "Loading...";
  
  @override
  void initState() {
    super.initState();
    _loadProduct();
  }
    
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
      return Scaffold(
        appBar: AppBar(
          title: Text('MyShop'),
          backgroundColor: Colors.green,
        ),
        body: Center(
          child: Container(
            child: Column(
              children: [productlist == null
                ? Flexible(child: Center(child: Text(_titlecenter)))
                : Flexible(
                  child: Center(
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio:(screenWidth / screenHeight) / 0.9,
                      children:List.generate(productlist.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.all(7),
                          child: Card(
                            elevation:10,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: screenHeight / 4.5,
                                  width: screenWidth / 1,
                                  child: CachedNetworkImage(
                                    imageUrl:"https://crimsonwebs.com/s271304/myshop/images/${productlist[index]['prid']}.png",
                                  ),
                                ),
                                SizedBox(height: 5),
                                Padding(padding:EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: Text("Product ID: "+productlist[index]['prid'],style: TextStyle(fontSize: 16))),
                                SizedBox(height:8),
                                Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                10, 0, 0, 0),
                                            child: Text(
                                                "Name: " +
                                                    productlist[index]['prname'],
                                                style:
                                                    TextStyle(fontSize: 16))),
                                  SizedBox(height: 8),
                                  Padding(padding:EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: Text("Type: "+productlist[index]['prtype'],style: TextStyle(fontSize: 16))),
                                  SizedBox(height:10),
                                  Padding(padding:EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: Text("Price:RM "+productlist[index]['prprice'],style: TextStyle(fontSize: 16))),
                                  SizedBox(height:10),
                                  Padding(padding:EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: Text("Quantity: "+productlist[index]['prqty'],style: TextStyle(fontSize: 16))),
                                  SizedBox(height: 8),
                              ],
                            )),
                          );
                        }))
                      )
                    ),
                  ],
                )
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            icon: Icon(Icons.add),
            label: Text('New Product'),
            backgroundColor: Colors.green,
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (content) => NewProduct())
              );
        },
      ),
    );
  }
    
  void _loadProduct() {
    http.post(
      Uri.parse(
        "http://crimsonwebs.com/s271304/myshop/php/loadproduct.php"),
        body: {  
        }).then((response) {   
      if (response.body == "nodata") {
        _titlecenter = "Sorry no product";
        return;
      } else {
        var jsondata = json.decode(response.body);
        productlist = jsondata["products"];
        setState(() {
          print(productlist);
        });
      }
    });
  }
}