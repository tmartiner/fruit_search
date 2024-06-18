import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final searchcontroller = TextEditingController();

  late String fruit = "";
  late String family = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Fruits Search"),
        ),
        body: Center(
          child: Column(
            children: [
              TextField(
                controller: searchcontroller,
              ),
              FilledButton(
                onPressed: () async {
                  final response = await get(
                    Uri.parse(
                        "https://www.fruityvice.com/api/fruit/${searchcontroller.text}"),
                  );
                  String jsonString = response.body;
                  Map<String, dynamic> m = jsonDecode(jsonString);

                  setState(() {
                    fruit = m["name"];
                    family = m["family"];
                  });
                },
                child: const Text("Search"),
              ),
              Text(
                fruit,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                family,
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
