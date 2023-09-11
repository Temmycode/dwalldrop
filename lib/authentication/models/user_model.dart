import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String username;
  final String email;
  final String uid;

  const UserModel({
    required this.email,
    required this.uid,
    required this.username,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'email': email,
        'uid': uid,
      };

  factory UserModel.fromJson(DocumentSnapshot snapshot) {
    final snap = snapshot.data() as Map<String, dynamic>;
    return UserModel(
      username: snap['username'],
      email: snap['email'],
      uid: snap['uid'],
    );
  }
}
