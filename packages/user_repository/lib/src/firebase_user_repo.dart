import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_repository/src/models/user.dart';
import 'package:user_repository/src/user_repo.dart';

class FirebaseUserRepo implements UserRepository{
  final FirebaseAuth _firebaseAuth;
  final userCollection = FirebaseFirestore.instance.collection('users');

   FirebaseUserRepo({
    FirebaseAuth? firebaseAuth,
  }): _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Stream<User?> get user {
      return _firebaseAuth.authStateChanges().map((firebaseUser){
        return firebaseUser;
      });
  }

  @override
  Future<void> signIn(String email, String password) async {
    try {
        await _firebaseAuth.signInWithEmailAndPassword(
          email: email, 
          password: password
          );
    } catch (e) {
      log(e.toString() as num);
      rethrow;
    }
  }


  @override
  Future<MyUser> signUp(MyUser myUser, String password) async {
     try {
       UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
         email: myUser.email,
         password: password
       );
        User? user = userCredential.user;

         await user!.updateDisplayName(myUser.name);
         await user.reload();

         myUser = myUser.copyWith(
           userId: user.uid,
           name: user.displayName
         );

        return myUser;
    } catch (e) {
      log(e.toString() as num);
      rethrow;
    }
  }

 
    @override
  Future<void> setUserData(MyUser myUser) async {
      try {
        await userCollection
        .doc(myUser.userId)
        .set(myUser.toEntity().toDocument());
    } catch (e) {
      log(e.toString() as num);
      rethrow;
    }
  }

 @override
	Future<void> logOut() async {
		await _firebaseAuth.signOut();

	}
}