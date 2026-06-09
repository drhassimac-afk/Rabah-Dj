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
  final ImagePicker picker = ImagePicker();
  XFile? selectedImage;

  final TextEditingController usernameCtrl = TextEditingController();
  final TextEditingController contentCtrl = TextEditingController();

  List<Map<String, dynamic>> posts = [];

  @override
  void initState() {
    super.initState();
    loadPosts();
  }

  @override
  void dispose() {
    usernameCtrl.dispose();
    contentCtrl.dispose();
    super.dispose();
  }

  Future<void> loadPosts() async {
    final data = await DatabaseService.getPosts();

    setState(() {
      posts = data;
    });
  }

  Future<void> addPost() async {
    if (contentCtrl.text.isEmpty && selectedImage == null) {
      return;
    }

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

    setState(() {
      selectedImage = null;
    });
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
                        Text(post["text"]?.toString() ?? ""),
                        if (post["image"] != null)
                          Image.file(
                            File(post["image"].toString()),
                          ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.favorite),
                              onPressed: () {
                                setState(() {
                                  post["likes"] =
                                      (post["likes"] ?? 0) + 1;
                                });
                              },
                            ),
                            Text(
                              (post["likes"] ?? 0).toString(),
                            ),
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
