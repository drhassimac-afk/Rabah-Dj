import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
const ProfileScreen({super.key});

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text("Profile"),
centerTitle: true,
),

```
  body: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [

      const CircleAvatar(
        radius: 50,
        backgroundColor: Colors.grey,
        child: Icon(
          Icons.person,
          size: 60,
          color: Colors.white,
        ),
      ),

      const SizedBox(height: 20),

      const Text(
        "RabahDj",
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),

      const SizedBox(height: 10),

      const Text(
        "🚀 Welcome to RabahDj Pro",
        style: TextStyle(
          color: Colors.grey,
        ),
      ),

      const SizedBox(height: 30),

      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [

          Column(
            children: [
              Text("10", style: TextStyle(fontSize: 18)),
              Text("Posts"),
            ],
          ),

          Column(
            children: [
              Text("120", style: TextStyle(fontSize: 18)),
              Text("Likes"),
            ],
          ),

          Column(
            children: [
              Text("50", style: TextStyle(fontSize: 18)),
              Text("Followers"),
            ],
          ),

        ],
      )

    ],
  ),
);
```

}
}
