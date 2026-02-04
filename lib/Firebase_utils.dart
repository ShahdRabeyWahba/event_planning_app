import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planning_app/models/event.dart';
import 'package:event_planning_app/models/my_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseUtils {
  static CollectionReference<Event> getEventCollection() {
    return FirebaseFirestore.instance
        .collection(Event.collectionName)
        .withConverter<Event>(
          fromFirestore: (snapshot, options) =>
              Event.fromFirestore(snapshot.data()),
          toFirestore: (event, options) => event.toFirestore(),
        );
  }

  static Future<void> addEventToFirestore(Event event) {
    var collection = getEventCollection();
    var docRef = collection.doc();
    event.id = docRef.id;
    return docRef.set(event);
  }
  static Future<void> deleteEvent(String id) {
    return getEventCollection().doc(id).delete();
  }

  static Future<void> updateEvent(Event event) {
    return getEventCollection().doc(event.id).set(event);
  }

  // --- User Management ---

  static CollectionReference<MyUser> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
          fromFirestore: (snapshot, options) =>
              MyUser.fromFirestore(snapshot.data()),
          toFirestore: (user, options) => user.toFirestore(),
        );
  }

  static Future<void> addUserToFirestore(MyUser user) {
    return getUsersCollection().doc(user.id).set(user);
  }

  static Future<MyUser?> readUserFromFirestore(String id) async {
    var querySnapshot = await getUsersCollection().doc(id).get();
    return querySnapshot.data();
  }

  // --- Authentication ---

  static Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) {
    return FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  static Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) {
    return FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  static Future<void> resetPassword(String email) {
    return FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  static Future<void> logout() {
    return FirebaseAuth.instance.signOut();
  }

  static Future<UserCredential?> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    if (googleAuth == null) return null;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}