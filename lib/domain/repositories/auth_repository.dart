import '../entities/user_profile.dart';

/// Interface du repository pour l'authentification
abstract class AuthRepository {
  /// Stream de l'état d'authentification
  Stream<UserProfile?> get authStateChanges;

  /// Utilisateur actuellement connecté
  UserProfile? get currentUser;

  /// Inscription avec email et mot de passe
  Future<UserProfile> signUp({
    required String email,
    required String password,
    String? displayName,
  });

  /// Connexion avec email et mot de passe
  Future<UserProfile> signIn({required String email, required String password});

  /// Déconnexion
  Future<void> signOut();

  /// Réinitialisation du mot de passe
  Future<void> resetPassword(String email);

  /// Met à jour le profil utilisateur
  Future<void> updateProfile({String? displayName, String? photoUrl});
}
