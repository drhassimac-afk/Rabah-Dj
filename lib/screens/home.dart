import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../services/database_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
Future<void> loadPosts() async {
final data = await DatabaseService.getPosts();

setState(() {
posts = data;
});
}


  final ImagePicker picker = ImagePicker();
  XFile? selectedImage;

  final usernameCtrl = TextEditingController();
  final contentCtrl = TextEditingController();

  List<Map<String, dynamic>> posts = [
    {
      "user": "RabahDj",
      "text": "مرحباً بكم في RabahDj Pro 🚀",
      "likes": 12,
      "image": null,
    },
    {
      "user": "Admin",
      "text": "أول منشور في التطبيق",
      "likes": 5,
      "image": null,
    }
  ];

  Future<void> addPost() async {
if (contentCtrl.text.isEmpty && selectedImage == null) return;

final post = {
"user": usernameCtrl.text.isEmpty
? "RabahDj"
: usernameCtrl.text,
"text": contentCtrl.text,
"image": selectedImage?.path,
"likes": 0,
};

await DatabaseService.insertPost(post);

await loadPosts();

contentCtrl.clear();
selectedImage = null;
}


    if (contentCtrl.text.isEmpty && selectedImage == null) return;

    setState(() {
      posts.insert(0, {
        "user": usernameCtrl.text.isEmpty ? "RabahDj" : usernameCtrl.text,
        "text": contentCtrl.text,
        "image": selectedImage?.path,
        "likes": 0,
      });
    });

    contentCtrl.clear();
    selectedImage = null;
  }

  Future<void> pickImage() async {
  final image = await picker.pickImage(
    source: ImageSource.gallery,
  );

  if (image != null) {
    setState(() {
      selectedImage = image;
    });
  }
}

@override
void initState() {
  super.initState();
  loadPosts();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("RabahDj Pro"),
        centerTitle: true,
      ),

      body: Column(
        children: [

          TextField(
            controller: usernameCtrl,
            decoration: const InputDecoration(
              hintText: "Username",
            ),
          ),

          TextField(
            controller: contentCtrl,
            decoration: const InputDecoration(
              hintText: "What's happening?",
            ),
          ),

          Row(
            children: [
              ElevatedButton(
                onPressed: addPost,
                child: const Text("Post 🚀"),
              ),

              IconButton(
                onPressed: pickImage,
                icon: const Icon(Icons.image),
              ),
            ],
          ),

          Expanded(
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];

                return Card(
                  margin: const EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(
                          "@${post["user"]}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Text(post["text"]),

                        if (post["image"] != null)
                          Image.file(File(post["image"])),

                        const SizedBox(height: 15),

                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.favorite),
                              onPressed: () {
                                setState(() {
                                  post["likes"]++;
                                });
                              },
                            ),

                            Text(post["likes"].toString()),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
