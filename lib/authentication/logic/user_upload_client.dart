import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dwalldrop/authentication/models/user_model.dart';
import 'package:dwalldrop/backend/constants/firestore_constants.dart';

class UseruploadClient {
  static Future<bool> uploadUserToDatabase(
    String userId,
    String email,
    String username,
  ) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      final userModel = UserModel(
        username: username,
        email: email,
        uid: userId,
      );

      // I NEED A FUNCTION TO CHECK IF THE USER IS ALREADY IN THE DATABASE OR NOT

      await firestore
          .collection(FirestoreConstants.usersCollection)
          .doc(userId)
          .set(
            userModel.toJson(),
          );
      return true;
    } catch (e) {
      return false;
    }
  }
}
