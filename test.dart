import 'package:flutter/material.dart';

class InstagramPost extends StatelessWidget {
  final String userProfileImage;
  final String username;
  final String postImage;
  final int likes;
  final bool isVerified;

  InstagramPost({
    required this.userProfileImage,
    required this.username,
    required this.postImage,
    required this.likes,
    this.isVerified = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Kullanıcı Profil Resmi ve Kullanıcı Adı
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(userProfileImage),
              ),
              SizedBox(width: 8),
              Text(
                username,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              // Onaylı Kullanıcı İkonu
              if (isVerified)
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Icon(
                    Icons.verified,
                    color: Colors.blue,
                    size: 20,
                  ),
                ),
            ],
          ),
          SizedBox(height: 8),
          // Gönderi Resmi
          Image.network(
            postImage,
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 8),
          // Beğeni Sayısı
          Row(
            children: [
              Icon(Icons.favorite, color: Colors.red),
              SizedBox(width: 4),
              Text(
                '$likes beğenme',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Instagram Gönderi Şablonu'),
      ),
      body: InstagramPost(
        userProfileImage:
            'https://res.cloudinary.com/divijw2qz/image/upload/v1702375336/WhatsApp_Image_2023-11-30_at_18.37.20.jpg',
        username: 'codermert',
        postImage:
            'https://res.cloudinary.com/divijw2qz/image/upload/v1702376223/snapedit_1700599908039.jpg',
        likes: 739,
        isVerified: true,
      ),
    ),
  ));
}
