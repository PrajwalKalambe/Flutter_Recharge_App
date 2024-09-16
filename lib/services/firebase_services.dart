import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  FirebaseService._()
    : _auth = FirebaseAuth.instance,
      _firestore = FirebaseFirestore.instance;

  static final FirebaseService _instance = FirebaseService._();

  factory FirebaseService() => _instance;

  static Future<void> initializeApp() async {
    await Firebase.initializeApp();
  }

  // Auth methods
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
    return await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<UserCredential> createUserWithEmailAndPassword(String email, String password) async {
    return await _auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Firestore methods
  Future<void> addDocument(String collection, Map<String, dynamic> data) async {
    await _firestore.collection(collection).add(data);
  }

  Future<void> updateDocument(String collection, String documentId, Map<String, dynamic> data) async {
    await _firestore.collection(collection).doc(documentId).update(data);
  }

  Future<DocumentSnapshot> getDocument(String collection, String documentId) async {
    return await _firestore.collection(collection).doc(documentId).get();
  }

  Stream<QuerySnapshot> getCollectionStream(String collection) {
    return _firestore.collection(collection).snapshots();
  }

  // User-specific methods
  Future<void> createUserProfile(String userId, Map<String, dynamic> userData) async {
    await _firestore.collection('users').doc(userId).set(userData);
  }

  Future<DocumentSnapshot> getUserProfile(String userId) async {
    return await _firestore.collection('users').doc(userId).get();
  }

  // Transaction methods
  Future<void> addTransaction(Map<String, dynamic> transactionData) async {
    await _firestore.collection('transactions').add(transactionData);
  }

  Stream<QuerySnapshot> getUserTransactions(String userId) {
    return _firestore
        .collection('transactions')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}