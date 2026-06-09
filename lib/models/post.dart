class Post {
  final int? id;
  final String user;
  final String text;
  final String? image;
  final String? avatar;
  final int likes;

  Post({
    this.id,
    required this.user,
    required this.text,
    this.image,
    this.avatar,
    this.likes = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user': user,
      'text': text,
      'image': image,
      'avatar': avatar,
      'likes': likes,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['id'],
      user: map['user'],
      text: map['text'],
      image: map['image'],
      avatar: map['avatar'],
      likes: map['likes'] ?? 0,
    );
  }
}
