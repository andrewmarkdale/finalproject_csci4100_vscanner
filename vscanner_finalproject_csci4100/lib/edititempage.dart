import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vscanner_finalproject_csci4100/db_helper.dart';
import 'dart:convert';
import 'package:vscanner_finalproject_csci4100/bottomappbar.dart';

class edititempage extends StatefulWidget {
  const edititempage(
      {Key? key,
      required this.title,
      required this.image1,
      required this.image2,
      required this.mapImage,
      required this.barcode})
      : super(key: key);
  final String title;
  final String image1;
  final String image2;
  final String barcode;
  final String mapImage;
  @override
  State<StatefulWidget> createState() => _edititempagestate();
}

class _edititempagestate extends State<edititempage> {
  TextEditingController notes = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                const Padding(padding: EdgeInsets.only(top: 10)),
                Row(children:[Padding(padding: EdgeInsets.only(left:300)),
                  Container(
                  decoration: BoxDecoration(
                            color: Colors.grey[700],
                            borderRadius: BorderRadius.circular(10)),
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: IconButton(
                onPressed: () async {_showAlertDialog(context);},
                icon: Icon(FontAwesomeIcons.trashAlt,color: Colors.white,)),
                alignment: Alignment.center,
                ),]),
                Padding(
                    child: 
                Text(
                  widget.title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize:25),
                ),
                padding: EdgeInsets.only(left: 5)),

                const Padding(padding: EdgeInsets.only(top: 10)),
                Padding(
                  child: Text(
                    'Barcode: ${widget.barcode}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                padding: EdgeInsets.only(left:10),),
                const Padding(padding: EdgeInsets.only(top: 10)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(left:20)),
                    Image.asset(
                      widget.image1,
                      width: 50,
                      height: 50,
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * .1),
                    Image.asset(
                      widget.image2,
                      width: 50,
                      height: 50,
                    ),
                    //SizedBox(height: 100,),
                  ],
                ),
                SizedBox(height: 20),
                
                Padding(
                    padding: EdgeInsets.fromLTRB(
                        MediaQuery.of(context).size.width * .1,
                        20,
                        MediaQuery.of(context).size.width * .1,
                        20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Notes",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.fromLTRB(
                        MediaQuery.of(context).size.width * .1,
                        1,
                        MediaQuery.of(context).size.width * .1,
                        1),
                    child: TextFormField(
                      maxLength: 100,
                      maxLines: 15,
                      controller: notes,
                      decoration: const InputDecoration(
                        hintMaxLines: 15,
                        hintText: "Enter your notes here",
                      ),
                    )),
                const Padding(padding: EdgeInsets.only(top: 10)),
                Center(
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[700],
                            borderRadius: BorderRadius.circular(10)),
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: TextButton(
                            onPressed: () async {
                              print(notes.text);
                              int result =
                                  await DBHelper.dbHelper.updateProduct({
                                "name": widget.title,
                                "barcode": widget.barcode,
                                "vegan": widget.image1,
                                "vegetarian": widget.image2,
                                "imgb64": widget.mapImage,
                                "notes": notes.text,
                              });
                              print(result);
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Save Notes",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ))))
              ])),
        ));
  }

  Future<void> _showAlertDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Delete product?"),
            content: Text("This action cannot be undone"),
            actions: [
              TextButton(
                  onPressed: () {
                    DBHelper.dbHelper
                        .deleteProduct(widget.barcode);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Text("Delete")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel"))
            ],
          );
        });
  }
}
