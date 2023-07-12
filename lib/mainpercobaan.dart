import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Demo',
      home: ApiDataScreen(),
    );
  }
}

class ApiDataScreen extends StatefulWidget {
  @override
  _ApiDataScreenState createState() => _ApiDataScreenState();
}

class _ApiDataScreenState extends State<ApiDataScreen> {
  List<dynamic> apiData = [];

  Future<void> fetchData() async {
    final response = await http.get(
        Uri.parse('https://indonesia-public-static-api.vercel.app/api/heroes'));
    if (response.statusCode == 200) {
      setState(() {
        apiData = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API Stasiun Kereta Api'),
      ),
      body: SingleChildScrollView(
        child: Table(
          border: TableBorder.all(color: Colors.black),
          children: [
            TableRow(
              children: [
                TableCell(
                  child: Container(
                    color: Colors.blue,
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Nama',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                TableCell(
                  child: Container(
                    color: Colors.blue,
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Tanggal Lahir',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                TableCell(
                  child: Container(
                    color: Colors.blue,
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Tanggal Wafat',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                TableCell(
                  child: Container(
                    color: Colors.blue,
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Deskripsi',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            for (var data in apiData)
              TableRow(
                children: [
                  TableCell(
                    child: Container(
                      color: Colors.grey[200],
                      padding: EdgeInsets.all(8.0),
                      child: Text(data['name']),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      color: Colors.grey[200],
                      padding: EdgeInsets.all(8.0),
                      child: Text(int.parse(data['birth_year']).toString()),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      color: Colors.grey[200],
                      padding: EdgeInsets.all(8.0),
                      child: Text(int.parse(data['death_year']).toString()),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      color: Colors.grey[200],
                      padding: EdgeInsets.all(8.0),
                      child: Text(data['description']),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
