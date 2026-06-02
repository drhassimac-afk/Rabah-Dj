import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
const HomeScreen({super.key});

@override
State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
final List<Map<String, dynamic>> posts = [
{
"user": "RabahDj",
"text": "مرحباً بكم في RabahDj Pro 🚀",
"likes": 12,
},
{
"user": "Admin",
"text": "أول منشور في التطبيق",
"likes": 5,
}
];

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text("RabahDj Pro"),
centerTitle: true,
),
body: ListView.builder(
itemCount: posts.length,
itemBuilder: (context, index) {
return Card(
margin: const EdgeInsets.all(10),
child: Padding(
padding: const EdgeInsets.all(12),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
"@${posts[index]["user"]}",
style: const TextStyle(
fontWeight: FontWeight.bold,
fontSize: 18,
),
),
const SizedBox(height: 10),
Text(posts[index]["text"]),
const SizedBox(height: 15),
Row(
children: [
IconButton(
icon: const Icon(Icons.favorite),
onPressed: () {
setState(() {
posts[index]["likes"]++;
});
},
),
Text(posts[index]["likes"].toString()),
],
),
],
),
),
);
},
),
);
}
}
