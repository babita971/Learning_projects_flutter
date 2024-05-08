import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.teal,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('images/profile.jpg'),
                ),
                Text(
                  'Babita Bisht',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontFamily: 'Pacifico',
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'FLUTTER DEVELOPER',
                  style: TextStyle(
                      color: Colors.teal.shade100,
                      fontSize: 15,
                      fontFamily: 'Source Sans Pro',
                      // fontStyle: FontStyle.italic,
                      letterSpacing: 3),
                ),
                SizedBox(
                  height: 20,
                  width: 150,
                  child: Divider(color: Colors.white),
                ),
                Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 25),
                  child: ListTile(
                    leading: Icon(
                      Icons.call,
                      color: Colors.teal,
                    ),
                    title: Text(
                      '+44 123 456 789',
                      style: TextStyle(color: Colors.teal),
                    ),
                  ),
                ),
                Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 25),
                  child: ListTile(
                    leading: Icon(
                      Icons.email,
                      color: Colors.teal,
                    ),
                    title: Text(
                      'babitabisht@1234.tech',
                      style: TextStyle(color: Colors.teal),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Layout challenge
          //  Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // children: [
          //   Container(
          //     margin: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
          //     color: Colors.red,
          //     width: 100,
          //     height: double.infinity,
          //   ),
          //   Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Container(
          //         color: Colors.yellow,
          //         width: 100,
          //         height: 100,
          //       ),
          //       Container(
          //         color: Colors.green,
          //         width: 100,
          //         height: 100,
          //       ),
          //     ],
          //   ),
          //   Container(
          //     margin: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
          //     color: Colors.blue,
          //     width: 100,
          //     height: double.infinity,
          //   ),
          // ],
          // ),

          // miCard using rows and containers
          // Container(
          //       padding: EdgeInsets.all(10),
          //       margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          //       // color: Colors.white,
          //       decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(5),
          //           color: Colors.white),
          //       child: Row(
          //         children: [
          //           Icon(
          //             Icons.call,
          //             color: Colors.teal,
          //           ),
          //           SizedBox(width: 20),
          //           Text(
          //             '+44 123 456 789',
          //             style: TextStyle(color: Colors.teal),
          //           ),
          //         ],
          //       ),
          //     ),
          //     Container(
          //       padding: EdgeInsets.all(10),
          //       margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          //       decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(5),
          //           color: Colors.white),
          //       child: Row(
          //         children: [
          //           Icon(
          //             Icons.email,
          //             color: Colors.teal,
          //           ),
          //           SizedBox(width: 20),
          //           Text(
          //             'babitabisht@antarx.tech',
          //             style: TextStyle(color: Colors.teal),
          //           ),
          //         ],
          //       ),
          //     ),
        ),
      ),
    );
  }
}
