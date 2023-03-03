// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Item Search',
//       theme: ThemeData(
//         primarySwatch: Colors.deepPurple,
//         scaffoldBackgroundColor: Color(0xFF100F1F),
//       ),
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
// class DetailsPage extends StatelessWidget {
//   final Map<String, dynamic> item;

//   const DetailsPage(this.item);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Item Details'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Store: ${item['store_name']}',
//               style: TextStyle(fontSize: 24),
//             ),
//             SizedBox(height: 16),
//             Text(
//               'Stock: ${item['stock']}',
//               style: TextStyle(fontSize: 18),
//             ),
//             SizedBox(height: 16),
//             Text(
//               'Location: (${item['lat']}, ${item['long']})',
//               style: TextStyle(fontSize: 18),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// class _MyHomePageState extends State<MyHomePage> {
//   final _itemNameController = TextEditingController();
//   List<Map<String, dynamic>> _searchResults = [];
//   bool _loading = false;

//   Future<void> _searchItem() async {
//     setState(() {
//       _loading = true;
//     });

//     final itemName = _itemNameController.text.trim().toLowerCase();
//     final url = 'https://some-api-ithinglol.vercel.app/$itemName';

//     try {
//       final response = await Dio().get(url);

//       if (response.statusCode == 200) {
//   final data = response.data;
//   setState(() {
//     _searchResults = List<Map<String, dynamic>>.from(data)
//         .map((result) => {
//               ...result,
//               'id': '${result['store_name']}_${result['stock']}_${result['lat']}_${result['long']}'
//             })
//         .toList();
//     _loading = false;
//   });
// } else {
//   setState(() {
//     _searchResults = [];
//     _loading = false;
//   });
// }

//     } catch (error) {
//       setState(() {
//         _searchResults = [];
//         _loading = false;
//       });
//     }
//   }
//   void _showDetailsPage(Map<String, dynamic> selectedItem) {
//   Navigator.push(
//     context,
//     MaterialPageRoute(builder: (context) => DetailsPage(selectedItem)),
//   );
// }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Item Search'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _itemNameController,
//               decoration: InputDecoration(
//                 labelText: 'Item Name',
//                 labelStyle: TextStyle(color: Colors.grey),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(20),
//                   borderSide: BorderSide.none,
//                 ),
//                 filled: true,
//                 fillColor: Color(0xFF161525),
//               ),
//               style: TextStyle(color: Colors.white),
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: _searchItem,
//               child: Container(
//                 width: double.infinity,
//                 height: 50,
//                 child: Center(
//                   child: _loading
//                       ? CircularProgressIndicator()
//                       : Text(
//                           'Search',
//                           style: TextStyle(fontSize: 18),
//                         ),
//                 ),
//                 decoration: BoxDecoration(
//                   color: Color(0xFF6034A7),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//               ),
//               style: ButtonStyle(
//                 shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                   RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 16),
//             _searchResults.isNotEmpty
//                 ? Expanded(
//                     child: ListView.builder(
//                         itemCount: _searchResults.length,
//   itemBuilder: (context, index) {
//     return GestureDetector(
//       onTap: () => _showDetailsPage(_searchResults[index]),
//       child: Card(
//                           color: Color(0xFF6034A7),
//                           child: Padding(
//                             padding: const EdgeInsets.all(16.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Store: ${_searchResults[index]['store_name']}',
//                                   style: TextStyle(
//                                       color: Colors.white, fontSize: 18),
//                                 ),
//                                 SizedBox(height: 8),
//                                 Text(
//                                   'Stock: ${_searchResults[index]['stock']}',
//                                   style: TextStyle(
//                                       color: Colors.white, fontSize: 16),
//                                 ),
//                                 SizedBox(height: 8),
//                                 Row(
//                                   children: [
//                                     Icon(
//                                       Icons.location_on,
//                                       color: Colors.white,
//                                     ),
//                                     SizedBox(width: 8),
//                                     Text(
//                                       'Lat: ${_searchResults[index]['lat']}, Long: ${_searchResults[index]['long']}',
//                                       style: TextStyle(
//                                           color: Colors.white, fontSize: 14),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//     ));
//                       },
//                     ),
//                   )
//                 : SizedBox(),
//           ],
//         ),
//       ),
//     );
//   }
// }
