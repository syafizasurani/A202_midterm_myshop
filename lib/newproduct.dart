import 'dart:convert';
import 'dart:io';
import 'main.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class NewProduct extends StatefulWidget {
  @override
  _NewProductState createState() => _NewProductState();
}

class _NewProductState extends State<NewProduct> {
  double screenHeight, screenWidth;
  File _image;
  String pathAsset = 'assets/images/camera.png';
  TextEditingController _prnameController = new TextEditingController();
  TextEditingController _prtypeController = new TextEditingController();
  TextEditingController _prpriceController = new TextEditingController();
  TextEditingController _prqtyController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Add New Product'),
      ),
      body: Center(
        child: Container(
          child: Padding(
            padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
            child: SingleChildScrollView(
              child: Column(children: [
                GestureDetector(
                  onTap: ()=>{
                    _onPictureSelectionDialog()
                  },
                  child: Container(
                    height:screenHeight/3.2,
                    width:screenWidth/1.8,
                    decoration: BoxDecoration(
                      image:DecorationImage(
                        image: _image == null ? AssetImage(pathAsset) : FileImage(_image),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(
                        width: 3.0,
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20.0))
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Text("Tap to add image"),
                SizedBox(height: 5),
                TextField(
                  keyboardType: TextInputType.name,
                  controller: _prnameController,
                  style: GoogleFonts.openSans(
                    fontSize: 16.5,
                  ),
                  decoration: InputDecoration(
                    hintText: "Enter product name",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                    hintStyle: GoogleFonts.openSans(
                    color: Colors.green),
                  ),
                ),
                SizedBox(height: 5),
                TextField(
                  keyboardType: TextInputType.name,
                  controller: _prtypeController,
                  style: GoogleFonts.openSans(
                    fontSize: 16.5,
                  ),
                  decoration: InputDecoration(
                    hintText: "Enter product type",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                    hintStyle: GoogleFonts.openSans(
                    color: Colors.green),
                  ),
                ),
                SizedBox(height: 5),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: _prpriceController,
                  style: GoogleFonts.openSans(
                    fontSize: 16.5,
                  ),
                  decoration: InputDecoration(
                    hintText: "Enter price (RM)",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                    hintStyle: GoogleFonts.openSans(
                    color: Colors.green),
                  ),
                ),
                SizedBox(height: 5),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: _prqtyController,
                  style: GoogleFonts.openSans(
                    fontSize: 16.5,
                  ),
                  decoration: InputDecoration(
                    hintText: "Enter quantity",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                    hintStyle: GoogleFonts.openSans(
                    color: Colors.green),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  child: MaterialButton(
                    onPressed: () => { _addProductDialog() },
                    color: Colors.green,
                    shape:RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)
                    ),      
                    child: Text("Add Product",
                    style: GoogleFonts.openSans(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),),
                  ),
                ),
              ],),
            ),
          ),
        ),
      ),
    );
  }

  _onPictureSelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          //backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
            content: new Container(
              //color: Colors.white,
              height: screenHeight / 4,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Take picture from:",
                      style: GoogleFonts.openSans(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)
                          ),
                          minWidth: 80,
                          height: 80,
                          child: Text('Camera',
                            style: GoogleFonts.openSans(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          color: Colors.green,
                          elevation: 10,
                          onPressed: () => {Navigator.pop(context), _chooseCamera()},
                      ),
                    ),
                    SizedBox(width: 10),
                    Flexible(
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)
                        ),
                        minWidth:80,
                        height: 80,
                        child: Text('Gallery',
                          style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        color: Colors.green,
                        elevation: 10,
                        onPressed: () => {Navigator.pop(context), _chooseGallery()},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future _chooseCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(
      source: ImageSource.camera,
      maxHeight: 800,
      maxWidth: 800,
    );
    setState(() {
      if (pickedFile != null) {
      _image = File(pickedFile.path);
    } else {
      print('No image selected');
    }
    });
  }

  _chooseGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
      maxHeight: 800,
      maxWidth: 800,
    );
    setState(() {
      if (pickedFile != null) {
      _image = File(pickedFile.path);
    } else {
      print('No image selected');
    }
    });
  }

  _addProductDialog() {
    if(_image != null && _prnameController.text.toString() =="" && _prtypeController.text.toString() =="" && 
    _prpriceController.text.toString() =="" && _prqtyController.text.toString() ==""){
      Fluttertoast.showToast(
        msg: "Adding new product failed. Please fill all details.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0),),),
        title: Text("Add New Product",
          style: GoogleFonts.openSans(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold
          ),
        ),
        content: Text("Are you sure?",
          style: GoogleFonts.openSans(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
        actions: [
          TextButton(child: Text("Cancel",
            style: GoogleFonts.openSans(
              color: Colors.red,
              fontSize: 18,
              fontWeight: FontWeight.bold
            ),
          ), 
          onPressed: (){
            Navigator.of(context).pop();
          },),
          TextButton(child: Text("OK",
            style: GoogleFonts.openSans(
              color: Colors.green,
              fontSize: 18,
              fontWeight: FontWeight.bold
            ),
          ), 
          onPressed: (){
            Navigator.of(context).pop();
            _addProduct();
          },),
        ],
      );
    });
  }

  void _addProduct() {
    String base64Image = base64Encode(_image.readAsBytesSync());
    String prname = _prnameController.text.toString();
    String prtype = _prtypeController.text.toString();
    String prprice = _prpriceController.text.toString();
    String prqty = _prqtyController.text.toString();

    http.post(
      Uri.parse("https://crimsonwebs.com/s271304/myshop/php/newproduct.php"),
      body: {"prname": prname, "prtype": prtype, "prprice": prprice, 
      "prqty": prqty, "encoded_string": base64Image}).then((response) {
        print(response.body);
        if (response.body=="failed"){
          Fluttertoast.showToast(
            msg: "Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 18.0);
          return;
        }else{
          Fluttertoast.showToast(
            msg: "Product Successfully Added",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 18.0);

          setState(() {
            _image=null;
            _prnameController.text ="";
            _prtypeController.text ="";
            _prpriceController.text ="";
            _prqtyController.text ="";
          });
          Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (content) => MyShop()));
          return;
        }
      }
    );
  }

}