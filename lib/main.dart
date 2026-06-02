import 'package:flutter/material.dart';

void main() {
runApp(const RabahDj());
}

class RabahDj extends StatelessWidget {
const RabahDj({super.key});

@override
Widget build(BuildContext context) {
return MaterialApp(
debugShowCheckedModeBanner: false,
title: 'RabahDj Pro',
theme: ThemeData.dark(),
home: const HomePage(),
);
}
}

class HomePage extends StatefulWidget {
const HomePage({super.key});

@override
State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
List<Map<String, dynamic>> posts = [];

final usernameCtrl = TextEditingController();
final contentCtrl = TextEditingController();

void addPost() {
if (contentCtrl.text.isEmpty) return;

```
setState(() {
  posts.insert(0, {
    "user": usernameCtrl.text.isEmpty
        ? "RabahDj"
        : usernameCtrl.text,
    "content": contentCtrl.text,
    "likes": 0,
  });
});

contentCtrl.clear();
```

}

void likePost(int index) {
setState(() {
posts[index]["likes"]++;
});
}

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text("📸 RabahDj Pro"),
centerTitle: true,
),
body: Column(
children: [
Padding(
padding: const EdgeInsets.all(8),
child: TextField(
controller: usernameCtrl,
decoration: const InputDecoration(
hintText: "Username",
),
),
),
Padding(
padding: const EdgeInsets.all(8),
child: TextField(
controller: contentCtrl,
decoration: const InputDecoration(
hintText: "What's happening?",
),
),
),
ElevatedButton(
onPressed: addPost,
child: const Text("Post 🚀"),
),
Expanded(
child: ListView.builder(
itemCount: posts.length,
itemBuilder: (context, i) {
final post = posts[i];

```
            return Card(
              child: ListTile(
                title: Text("@${post['user']}"),
                subtitle: Text(post['content']),
                trailing: IconButton(
                  icon: Text("❤️ ${post['likes']}"),
                  onPressed: () => likePost(i),
                ),
              ),
            );
          },
        ),
      )
    ],
  ),
);
```

}
}
