import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'listproducts.dart';
import 'product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'db_helper.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';
import 'package:vscanner_finalproject_csci4100/bottomappbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'VegeScanner'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String barcodeScanRes = '';
  bool searchSwitch = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        centerTitle: true,
        elevation: searchSwitch ? 0.0 : 4.0,
        title: Image.asset(
          'images/vegescannerlong.png',
          fit: BoxFit.contain,
          height: 32,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Image.asset(
            'images/vegescanner_homescreen_splash.png',
            height: MediaQuery.of(context).size.height * .25,
            width: MediaQuery.of(context).size.width * 0.75,
          )),
          const Text(
            "Vegescanner is proudly powered by:",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
          ),
          Center(
              child: Image.asset(
            'images/openfoodfacts.png',
            height: MediaQuery.of(context).size.height * .125,
            width: MediaQuery.of(context).size.width * 0.25,
          )),
          SizedBox(
            height: MediaQuery.of(context).size.height * .05,
          ),
        ],
      ),
      /* floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
          height: 80,
          width: 80,
          child: FloatingActionButton(
            backgroundColor: Colors.grey[700],
            onPressed: () async {
              var barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                  "#228B22", "Cancel", true, ScanMode.BARCODE);
              getProductInformation(barcodeScanRes);

              setState(() {});
            },
            child: const Icon(
              FontAwesomeIcons.barcode,
              size: 35,
            ),
            elevation: 5.0,
          )), */
      bottomNavigationBar: const BottomAppBarWidget(),
    );
  }
}
