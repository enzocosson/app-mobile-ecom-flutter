import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/auth_repository.dart';

/// Implémentation du AuthRepository avec Firebase Auth
class AuthRepositoryImpl implements AuthRepository {
  final firebase.FirebaseAuth _firebaseAuth;
  final GoogleSignIn? _googleSignIn;

  AuthRepositoryImpl({
    firebase.FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
  }) : _firebaseAuth = firebaseAuth ?? firebase.FirebaseAuth.instance,
       // Désactiver Google Sign-In sur Web pour éviter l'erreur de Client ID
       _googleSignIn = kIsWeb ? null : (googleSignIn ?? GoogleSignIn());

  @override
  Stream<UserProfile?> get authStateChanges {
    return _firebaseAuth.authStateChanges().map((user) {
      if (user == null) return null;
      return _userToProfile(user);
    });
  }

  @override
  UserProfile? get currentUser {
    final user = _firebaseAuth.currentUser;
    if (user == null) return null;
    return _userToProfile(user);
  }

  @override
  Future<UserProfile> signUp({
    required String email,
    required String password,
    String? displayName,
  }) async {
    try {
      print('🔐 Tentative de création de compte pour: $email');

      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(), // Trim pour éviter les espaces
        password: password,
      );

      print('✅ Compte créé avec succès');

      if (displayName != null && credential.user != null) {
        await credential.user!.updateDisplayName(displayName);
      }

      if (credential.user == null) {
        throw Exception('Échec de la création du compte');
      }

      return _userToProfile(credential.user!);
    } on firebase.FirebaseAuthException catch (e) {
      print('❌ Erreur Firebase Auth: ${e.code} - ${e.message}');
      throw _handleAuthException(e);
    } catch (e) {
      print('❌ Erreur inattendue: $e');
      rethrow;
    }
  }

  @override
  Future<UserProfile> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) {
        throw Exception('Échec de la connexion');
      }

      return _userToProfile(credential.user!);
    } on firebase.FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  @override
  Future<void> signOut() async {
    await Future.wait([
      _firebaseAuth.signOut(),
      if (_googleSignIn != null) _googleSignIn.signOut(),
    ]);
  }

  /// Connexion avec Google Sign-In
  Future<UserProfile> signInWithGoogle() async {
    if (_googleSignIn == null) {
      throw Exception('Google Sign-In non disponible sur cette plateforme');
    }

    try {
      print('🔐 Tentative de connexion Google');

      // Déclencher le flux d'authentification
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        throw Exception('Connexion Google annulée');
      }

      print('✅ Utilisateur Google sélectionné: ${googleUser.email}');

      // Obtenir les détails d'authentification
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Créer une nouvelle credential
      final credential = firebase.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Se connecter à Firebase avec la credential
      final userCredential = await _firebaseAuth.signInWithCredential(
        credential,
      );

      if (userCredential.user == null) {
        throw Exception('Échec de la connexion Google');
      }

      print('✅ Connexion Firebase réussie');
      return _userToProfile(userCredential.user!);
    } on firebase.FirebaseAuthException catch (e) {
      print('❌ Erreur Firebase Auth: ${e.code} - ${e.message}');
      throw _handleAuthException(e);
    } catch (e) {
      print('❌ Erreur Google Sign-In: $e');
      throw Exception('Erreur lors de la connexion Google: $e');
    }
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on firebase.FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  @override
  Future<void> updateProfile({String? displayName, String? photoUrl}) async {
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      throw Exception('Aucun utilisateur connecté');
    }

    if (displayName != null) {
      await user.updateDisplayName(displayName);
    }
    if (photoUrl != null) {
      await user.updatePhotoURL(photoUrl);
    }
  }

  /// Convertit un User Firebase en UserProfile
  UserProfile _userToProfile(firebase.User user) {
    return UserProfile(
      id: user.uid,
      email: user.email ?? '',
      displayName: user.displayName,
      photoUrl: user.photoURL,
      createdAt: user.metadata.creationTime ?? DateTime.now(),
    );
  }

  /// Gère les exceptions Firebase Auth
  Exception _handleAuthException(firebase.FirebaseAuthException e) {
    print('🔍 Code d\'erreur Firebase: ${e.code}');
    print('🔍 Message d\'erreur: ${e.message}');

    switch (e.code) {
      case 'user-not-found':
        return Exception('Aucun utilisateur trouvé avec cet email');
      case 'wrong-password':
        return Exception('Mot de passe incorrect');
      case 'email-already-in-use':
        return Exception('Cet email est déjà utilisé');
      case 'weak-password':
        return Exception(
          'Le mot de passe est trop faible (minimum 6 caractères)',
        );
      case 'invalid-email':
        return Exception('Format d\'email invalide');
      case 'operation-not-allowed':
        return Exception(
          'L\'authentification par email/password n\'est pas activée dans Firebase Console. Veuillez l\'activer.',
        );
      case 'network-request-failed':
        return Exception('Erreur de connexion réseau');
      default:
        return Exception('Erreur d\'authentification: ${e.message ?? e.code}');
    }
  }
}
