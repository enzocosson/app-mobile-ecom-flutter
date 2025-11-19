import 'package:equatable/equatable.dart';

/// Entité UserProfile - Profil utilisateur
class UserProfile extends Equatable {
  final String id;
  final String email;
  final String? displayName;
  final String? photoUrl;
  final DateTime createdAt;

  const UserProfile({
    required this.id,
    required this.email,
    this.displayName,
    this.photoUrl,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, email, displayName, photoUrl, createdAt];
}
