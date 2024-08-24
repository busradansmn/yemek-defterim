import 'package:app/kalori1.dart';
import 'package:app/kalori10.dart';
import 'package:app/kalori11.dart';
import 'package:app/kalori12.dart';
import 'package:app/kalori2.dart';
import 'package:app/kalori3.dart';
import 'package:app/kalori4.dart';
import 'package:app/kalori5.dart';
import 'package:app/kalori6.dart';
import 'package:app/kalori7.dart';
import 'package:app/kalori8.dart';
import 'package:app/kalori9.dart';
import 'package:flutter/material.dart';

class kalori extends StatelessWidget {
  final List<Map<String, dynamic>> urunListesi = [
    {"page": kalori1(), "imagePath": "lib/assets/images/yemek1.jpg", "name": "MANTI"},
    {"page": kalori2(), "imagePath": "lib/assets/images/yemek2.jpg", "name": "YAPRAK SARMA"},
    {"page": kalori3(), "imagePath": "lib/assets/images/yemek3.jpg", "name": "KARNIYARIK"},
    {"page": kalori4(), "imagePath": "lib/assets/images/yemek4.jpg", "name": "KAYSERİ YAĞLAMASI"},
    {"page": kalori5(), "imagePath": "lib/assets/images/yemek5.jpg", "name": "LAZANYA"},
    {"page": kalori6(), "imagePath": "lib/assets/images/yemek6.jpg", "name": "PİZZA"},
    {"page": kalori7(), "imagePath": "lib/assets/images/yemek7.jpg", "name": "ŞEHRİYE SALATASI"},
    {"page": kalori8(), "imagePath": "lib/assets/images/yemek8.jpg", "name": "ÇÖKERTME"},
    {"page": kalori9(), "imagePath": "lib/assets/images/yemek9.jpg", "name": "KUMPİR"},
    {"page": kalori10(), "imagePath": "lib/assets/images/yemek10.jpg", "name": "PANKEK"},
    {"page": kalori11(), "imagePath": "lib/assets/images/yemek11.jpg", "name": "ADANA"},
    {"page": kalori12(), "imagePath": "lib/assets/images/yemek12.jpg", "name": "PEYNİRLİ BÖREK"},
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
      backgroundColor: Color.fromARGB(255, 254, 254, 254),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 249, 142, 28),
        title: Row(
          children: [
            Text('YEMEKLERİN KALORİLERİ'),
          ],
        ),
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
      height: MediaQuery.of(context).size.width / 4.5,
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
            Text(
              name,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
