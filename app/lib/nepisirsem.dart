import 'package:app/yemek10.dart';
import 'package:app/yemek2.dart';
import 'package:app/yemek3.dart';
import 'package:flutter/material.dart';

class BugunNePisirsemSayfasi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 249, 142, 28),
        title: Row(
          children: [

            Text('GÜNÜN MENÜSÜ'),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return _buildSquareButton(
            context,
            const Color.fromARGB(255, 255, 255, 255),
            index == 0 ? 'Kahvaltı' : (index == 1 ? 'Öğle Yemeği' : 'Akşam Yemeği'),
            index == 0 ? "lib/assets/images/yemek10.jpg" : (index == 1 ? "lib/assets/images/yemek2.jpg" : "lib/assets/images/yemek3.jpg"),
            index == 0 ? yemek10() : (index == 1 ? yemek2() : yemek3()),
          );
        },
      ),
      
    );
  }

  Widget _buildSquareButton(
      BuildContext context, Color color, String buttonText, String imagePath, Widget page) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width / 2.5,
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
            // Arka plan resim
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.asset(
                imagePath,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            // Buton üzerindeki metin
            Text(
              buttonText,
              style: TextStyle(
                fontSize: 20,
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
