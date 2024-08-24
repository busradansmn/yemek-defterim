import 'package:app/yemek1.dart';
import 'package:app/yemek10.dart';
import 'package:app/yemek11.dart';
import 'package:app/yemek12.dart';
import 'package:app/yemek2.dart';
import 'package:app/yemek3.dart';
import 'package:app/yemek4.dart';
import 'package:app/yemek5.dart';
import 'package:app/yemek6.dart';
import 'package:app/yemek7.dart';
import 'package:app/yemek8.dart';
import 'package:app/yemek9.dart';
import 'package:flutter/material.dart';

class urunler extends StatelessWidget {
  final List<Map<String, dynamic>> urunListesi = [
    {"page": yemek1(), "imagePath": "lib/assets/images/yemek1.jpg", "name": "MANTI"},
    {"page": yemek2(), "imagePath": "lib/assets/images/yemek2.jpg", "name": "YAPRAK SARMA"},
    {"page": yemek3(), "imagePath": "lib/assets/images/yemek3.jpg", "name": "KARNIYARIK"},
    {"page": yemek4(), "imagePath": "lib/assets/images/yemek4.jpg", "name": "KAYSERİ YAĞLAMASI"},
    {"page": yemek5(), "imagePath": "lib/assets/images/yemek5.jpg", "name": "LAZANYA"},
    {"page": yemek6(), "imagePath": "lib/assets/images/yemek6.jpg", "name": "PİZZA"},
    {"page": yemek7(), "imagePath": "lib/assets/images/yemek7.jpg", "name": "ŞEHRİYE SALATASI"},  
    {"page": yemek8(), "imagePath": "lib/assets/images/yemek8.jpg", "name": "ÇÖKERTME"},
    {"page": yemek9(), "imagePath": "lib/assets/images/yemek9.jpg", "name": "KUMPİR"},
    {"page": yemek10(), "imagePath": "lib/assets/images/yemek10.jpg", "name": "PANKEK"},
    {"page": yemek11(), "imagePath": "lib/assets/images/yemek11.jpg", "name": "ADANA KEBAP"},
    {"page": yemek12(), "imagePath": "lib/assets/images/yemek12.jpg", "name": "PEYNİRLİ BÖREK"},
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(urunListesi),
    );
  }
}

class HomePage extends StatelessWidget {
  final List<Map<String, dynamic>> urunListesi;

  HomePage(this.urunListesi);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
         backgroundColor: Color.fromARGB(255, 249, 142, 28),
        title: Text('TARİFLER'),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: urunListesi.length,
          itemBuilder: (context, index) {
            return _buildSquareButton(
              context,
              const Color.fromARGB(255, 255, 255, 255),
              urunListesi[index]["page"],
              urunListesi[index]["imagePath"],
              urunListesi[index]["name"],
            );
          },
        ),
      ),
    );
  }

  Widget _buildSquareButton(BuildContext context, Color color, Widget page, String imagePath, String name) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.5,
      height: MediaQuery.of(context).size.width / 1.9,
      margin: EdgeInsets.all(10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
        
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.asset(
                imagePath,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                color: Colors.black.withOpacity(0.5),
                width: MediaQuery.of(context).size.width / 1.5,
                child: Center(
                  child: Text(
                    name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
