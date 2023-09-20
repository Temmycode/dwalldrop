import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dwalldrop/authentication/models/user_model.dart';
import 'package:dwalldrop/backend/constants/database_constants.dart';

class UseruploadClient {
  static Future<bool> uploadUserToDatabase(
    String userId,
    String email,
    String username,
  ) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      final List<User> usersList = [];
      final userModel = User(
        username: username,
        email: email,
        uid: userId,
      );

      // I NEED A FUNCTION TO CHECK IF THE USER IS ALREADY IN THE DATABASE OR NOT
      final userSnapshot = await FirebaseFirestore.instance
          .collection(DatabaseConstants.usersCollection)
          .get();
      for (var user in userSnapshot.docs) {
        final newUser = User.fromJson(user);
        usersList.add(newUser);
      }
      if (usersList.contains(userModel)) {
        return true;
      } else {
        await firestore
            .collection(DatabaseConstants.usersCollection)
            .doc(userId)
            .set(
              userModel.toJson(),
            );
        return true;
      }
    } catch (e) {
      return false;
    }
  }
}
