// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:url_launcher/url_launcher.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'My App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: SearchPage(),
//     );
//   }
// }

// class LocationButton extends StatefulWidget {
//   const LocationButton({Key? key}) : super(key: key);

//   @override
//   _LocationButtonState createState() => _LocationButtonState();
// }

// class _LocationButtonState extends State<LocationButton> {
//   String? _itemName;
//   String? _errorMessage;
//   List<dynamic>? _availability;

//   Future<void> _getLocationAndSendRequest() async {
//     try {
//       final GeolocatorPlatform geolocator = GeolocatorPlatform.instance;
//       final Position? position = await geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.high);
//       final latitude = position?.latitude;
//       final longitude = position?.longitude;
//       print(_itemName);
//       print(latitude);
//       print(longitude);

//       final url = Uri.parse(
//           'https://some-api-ithinglol.vercel.app/api/$_itemName?latitude=$latitude&longitude=$longitude');
//       final response = await http.get(url);

//       if (response.statusCode == 200) {
//         final responseBody = json.decode(response.body);
//         setState(() {
//           _availability = responseBody;
//         });
//         print(responseBody);
//       } else {
//         setState(() {
//           _errorMessage =
//               'Error getting item availability: ${response.statusCode}';
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = 'Error getting location: $e';
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xff100f1f),
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         title: Text(
//           'Search Availability',
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//       body: Center(
//         child: Container(
//           margin: EdgeInsets.symmetric(horizontal: 20),
//           child:
//               Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
//             SizedBox(height: 40),
//             TextField(
//               onChanged: (value) {
//                 setState(() {
//                   _itemName = value;
//                 });
//               },
//               style: TextStyle(color: Colors.white),
//               decoration: InputDecoration(
//                 hintText: 'Enter item name',
//                 hintStyle: TextStyle(color: Colors.white),
//                 enabledBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: Color(0xff161525), width: 2),
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: Color(0xff161525), width: 2),
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//                 filled: true,
//                 fillColor: Color(0xff161525),
//               ),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _getLocationAndSendRequest,
//               child: Text(
//                 'Search',
//                 style: TextStyle(fontSize: 20),
//               ),
//               style: ButtonStyle(
//                 backgroundColor:
//                     MaterialStateProperty.all<Color>(Color(0xff6034a7)),
//                 shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                   RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                 ),
//               ),
//             ),
//             if (_errorMessage != null) ...[
//               SizedBox(height: 20),
//               Text(
//                 _errorMessage!,
//                 style: TextStyle(color: Colors.red),
//               ),
//             ],
//             if (_availability != null) ...[
//               SizedBox(height: 20),
//               Text(
//                 'Availability:',
//                 style: TextStyle(fontSize: 20),
//               ),
//               SizedBox(height: 20),
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: _availability!.length,
//                   itemBuilder: (context, index) {
//                     final availability = _availability![index];
//                     return Card(
//                       child: ListTile(
//   title: Text(availability['store_name']),
//   subtitle: Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Text('Quantity: ${availability['stock']}'),
//       SizedBox(height: 5),
//       Row(
//         children: [
//           Icon(Icons.location_on, color: Colors.grey, size: 20),
//           SizedBox(width: 5),
//           Text('Lat: ${availability['lat']}, Long: ${availability['long']}', style: TextStyle(color: Colors.grey)),
//         ],
//       ),
//     ],
//   ),
//   onTap: () async {
//     final latitude = availability['lat'];
//     final longitude = availability['long'];
//     final url = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
//     await launch(url);
//   },
// ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ]),
//         ),
//       ),
//     );
//   }
// }

// class SearchPage extends StatelessWidget {
//   const SearchPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: LocationButton(),
//     );
//   }
// }

// **   THIS IS MINIMAL BUT THIS WORKS TOO **

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:geolocator/geolocator.dart';
// import 'package:url_launcher/url_launcher.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter App',
//       theme: ThemeData.dark(),
//       home: HomePage(),
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final TextEditingController _itemController = TextEditingController();
//   String _errorMessage = '';
//   bool _isLoading = false;
//   List _results = [];

//   void _search() async {
//     setState(() {
//       _errorMessage = '';
//       _isLoading = true;
//       _results = [];
//     });

//     try {
//       Position position = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.high);
//       String item = _itemController.text;
//       String url = 'http://some-api-ithinglol.vercel.app/api/$item?latitude=${position.latitude}&longitude=${position.longitude}';
//       final response = await http.get(Uri.parse(url));
//       if (response.statusCode == 200) {
//         setState(() {
//           _isLoading = false;
//           _results = json.decode(response.body);
//         });
//       } else {
//         setState(() {
//           _isLoading = false;
//           _errorMessage = 'Error: ${response.statusCode}';
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _isLoading = false;
//         _errorMessage = 'Error: $e';
//       });
//     }
//   }

//   void _launchMaps(double lat, double long) async {
//     String url = 'https://www.google.com/maps/search/?api=1&query=$lat,$long';
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Flutter App'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             TextField(
//               controller: _itemController,
//               decoration: InputDecoration(
//                 labelText: 'Enter item',
//               ),
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: _isLoading ? null : _search,
//               child: _isLoading
//                   ? CircularProgressIndicator()
//                   : Text('Search'),
//             ),
//             SizedBox(height: 16.0),
//             if (_errorMessage.isNotEmpty)
//               Text(
//                 _errorMessage,
//                 style: TextStyle(color: Colors.red),
//               ),
//             if (_results.isNotEmpty)
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: _results.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     return Card(
//                       child: ListTile(
//                         title: Text(_results[index]['store_name']),
//                         subtitle: Text(
//                           'Item: ${_itemController.text}\nStock: ${_results[index]['stock']}',
//                         ),
//                         onTap: () => _launchMaps(
//                           _results[index]['lat'],
//                           _results[index]['long'],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Saadanam Kayyilundo?',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.purple,
        accentColor: Colors.purpleAccent,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.purple,
            onPrimary: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),
        ),
        cardTheme: CardTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _itemController = TextEditingController();
  String _errorMessage = '';
  bool _isLoading = false;
  List _results = [];

  void _search() async {
    setState(() {
      _errorMessage = '';
      _isLoading = true;
      _results = [];
    });

    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      String item = _itemController.text;
      String url =
          'http://some-api-ithinglol.vercel.app/api/fetch-item/$item?latitude=${position.latitude}&longitude=${position.longitude}';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        setState(() {
          _isLoading = false;
          _results = json.decode(response.body);
        });
      } else {
        setState(() {
          _isLoading = false;
          if (response.statusCode == 204) {
            _errorMessage = "Looks like there are no ${item} available nearby";
          } else {
            _errorMessage = 'Error: ${response.statusCode}';
          }
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Error: $e';
      });
    }
  }

  void _launchMaps(double lat, double long) async {
    String url = 'https://www.google.com/maps/search/?api=1&query=$lat,$long';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff100f1f),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 49, 9, 79),
        elevation: 0,
        title: Text(
          'Search Availability',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _itemController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Enter item name',
                hintStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff161525), width: 2),
                  borderRadius: BorderRadius.circular(30),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff161525), width: 2),
                  borderRadius: BorderRadius.circular(30),
                ),
                filled: true,
                fillColor: Color(0xff161525),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _isLoading ? null : _search,
              child: _isLoading ? CircularProgressIndicator() : Text('Search'),
            ),
            SizedBox(height: 16.0),
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            if (_results.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: _results.length,
                  itemBuilder: (context, index) {
                    Map result = _results[index];
                    print(_results[index]);
                    return Card(
                      child: ListTile(
                        title: Text(_results[index]['store_name']),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Item: ${_itemController.text}',
                            ),
                            Text(
                              'Stock: ${_results[index]['stock']}',
                            ),
                            Text(
                              'Price: ${_results[index]['price']}',
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.map),
                          onPressed: () {
                            _launchMaps(
                              _results[index]['lat'],
                              _results[index]['long'],
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
