# ShopFlutter - Application E-commerce Flutter

[![Flutter CI/CD](https://github.com/enzocosson/app-mobile-ecom-flutter/actions/workflows/flutter.yml/badge.svg)](https://github.com/enzocosson/app-mobile-ecom-flutter/actions/workflows/flutter.yml)
[![codecov](https://codecov.io/gh/enzocosson/app-mobile-ecom-flutter/branch/main/graph/badge.svg)](https://codecov.io/gh/enzocosson/app-mobile-ecom-flutter)
[![Vercel](https://img.shields.io/badge/Deployed%20on-Vercel-black?logo=vercel)](https://vercel.com)

Application e-commerce complète développée avec Flutter suivant les principes de **Clean Architecture** et **MVVM**. Déploiement automatique sur Vercel avec CI/CD GitHub Actions.

## 🌐 Démo en Ligne

- 🚀 **Production** : [https://your-project.vercel.app](https://your-project.vercel.app) *(à configurer)*
- 🔍 **Preview** : Automatique sur chaque Pull Request

## 🎯 Fonctionnalités

- ✅ **Authentification** avec Firebase Authentication (email/password)
- 🛍️ **Catalogue de produits** avec recherche et filtres par catégorie
- 🛒 **Panier d'achat** avec gestion des quantités
- 💳 **Checkout** avec paiement simulé (mock)
- 📦 **Historique des commandes**
- 👤 **Profil utilisateur** avec déconnexion
- 📱 **Adaptatif** : iOS (Cupertino), Android (Material), Web (PWA)
- 💾 **Persistence locale** avec Hive
- ⚡ **État géré** avec Riverpod

## 🏗️ Architecture

Le projet suit une architecture **Clean Architecture** en 3 couches :

```
lib/
├── domain/              # Couche métier (entities, repositories interfaces, use cases)
│   ├── entities/
│   ├── repositories/
│   └── usecases/
├── data/                # Couche de données (DTOs, models, services, repository implementations)
│   ├── models/
│   ├── services/
│   └── repositories/
├── presentation/        # Couche présentation (screens, widgets, viewmodels, router)
│   ├── screens/
│   ├── widgets/
│   ├── viewmodels/
│   └── router.dart
└── core/                # Configuration commune (providers)
    └── providers.dart
```

### Pattern MVVM

- **Model** : Entités du domaine (`Product`, `Order`, `CartItem`)
- **View** : Widgets Flutter (`LoginScreen`, `CatalogScreen`, etc.)
- **ViewModel** : StateNotifier Riverpod (`AuthViewModel`, `CatalogViewModel`, `CartViewModel`)

## 🚀 Installation

### Prérequis

- Flutter SDK >= 3.10.0
- Dart SDK >= 3.10.0
- Firebase CLI (pour le déploiement)
- Android Studio / Xcode (pour les builds natifs)

### Configuration

1. **Cloner le repository**

```bash
git clone https://github.com/YOUR_USERNAME/app_ecommerce.git
cd app_ecommerce
```

2. **Installer les dépendances**

```bash
flutter pub get
```

3. **Générer le code**

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

4. **Configurer Firebase**

   - Créer un projet Firebase
   - Ajouter les applications iOS, Android et Web
   - Télécharger les fichiers de configuration :
     - `google-services.json` (Android) → `android/app/`
     - `GoogleService-Info.plist` (iOS) → `ios/Runner/`
     - Exécuter `flutterfire configure` pour générer `firebase_options.dart`

5. **Lancer l'application**

```bash
flutter run
```

## 🧪 Tests

Le projet inclut des tests unitaires et widget avec une couverture ≥50%.

### Exécuter tous les tests

```bash
flutter test
```

### Exécuter les tests avec couverture

```bash
flutter test --coverage
```

### Voir le rapport de couverture

```bash
# Installer lcov (macOS)
brew install lcov

# Générer le rapport HTML
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

### Tests inclus

**Tests unitaires (5)** :

- `add_to_cart_usecase_test.dart` - Test du use case d'ajout au panier
- `search_products_usecase_test.dart` - Test de la recherche de produits
- `create_order_usecase_test.dart` - Test de création de commande
- `auth_viewmodel_test.dart` - Test du ViewModel d'authentification
- `catalog_viewmodel_test.dart` - Test du ViewModel du catalogue

**Tests widget (2)** :

- `product_card_test.dart` - Test du widget carte produit
- `product_list_test.dart` - Test de la liste de produits avec différents états

## 📦 Build Production

### Android APK

```bash
flutter build apk --release
```

### iOS IPA

```bash
flutter build ipa --release
```

### Web

```bash
flutter build web --release
```

## 🚢 Déploiement

### GitHub Pages

Le workflow CI/CD déploie automatiquement sur GitHub Pages lors d'un push sur `main`.

1. Activer GitHub Pages dans les paramètres du repository
2. Sélectionner la branche `gh-pages`
3. L'application sera accessible sur `https://YOUR_USERNAME.github.io/app_ecommerce/`

### Firebase Hosting

```bash
firebase login
firebase init hosting
firebase deploy
```

Ou via GitHub Actions (automatique sur push `main`) :

- Configurer `FIREBASE_SERVICE_ACCOUNT` dans les secrets GitHub
- Modifier `your-firebase-project-id` dans `.github/workflows/flutter.yml`

## 🛠️ Technologies

- **Flutter** 3.24.0+
- **State Management** : Riverpod
- **Navigation** : go_router
- **Authentification** : firebase_auth
- **Base de données locale** : Hive
- **API HTTP** : Dio
- **Tests** : mockito, faker
- **CI/CD** : GitHub Actions

## 📱 Adaptations Platforme

- **iOS** : Utilise `CupertinoPageScaffold` pour une expérience native
- **Android** : Intégration du partage avec `share_plus`
- **Web** : Configuration PWA avec manifest et service worker
- **Desktop** : Support Linux, macOS, Windows

## 🚀 Déploiement

### CI/CD Automatique

Ce projet utilise **GitHub Actions** + **Vercel** pour le déploiement automatique :

- ✅ **Preview Deployments** : Automatique sur chaque Pull Request
- ✅ **Production Deployments** : Automatique sur push vers `main`
- ✅ **Tests** : Exécutés avant chaque déploiement
- ✅ **Multi-plateforme** : Build Android, iOS, Web

**📖 Guides de déploiement :**
- [DEPLOYMENT_GUIDE.md](DEPLOYMENT_GUIDE.md) - Guide complet de configuration
- [DEPLOYMENT_QUICK.md](DEPLOYMENT_QUICK.md) - Référence rapide
- [CI_CD_ARCHITECTURE.md](CI_CD_ARCHITECTURE.md) - Architecture détaillée

**🔑 Configuration requise :**

Secrets GitHub à configurer :
```bash
VERCEL_TOKEN          # Token API Vercel
VERCEL_ORG_ID         # ID Organisation/User
VERCEL_PROJECT_ID     # ID du projet
```

**⚡ Script de pré-déploiement :**
```bash
./pre_deploy.sh  # Vérifie tout avant de pusher
```

## 🔒 Sécurité

- Authentification sécurisée via Firebase Auth
- Validation des entrées utilisateur
- Gestion des erreurs avec messages appropriés
- Tests de sécurité avec Dependabot activé

## 📄 Licence

Ce projet est un projet éducatif développé dans le cadre d'une formation IIM.

## 👤 Auteur

Enzo Cosson - IIM Digital School

## 🤝 Contribution

Les contributions sont les bienvenues ! Pour contribuer :

1. Fork le projet
2. Créer une branche feature (`git checkout -b feature/AmazingFeature`)
3. Commit les changements (`git commit -m 'Add AmazingFeature'`)
4. Push vers la branche (`git push origin feature/AmazingFeature`)
5. Ouvrir une Pull Request

Assurez-vous que :

- Le code est formaté (`flutter format .`)
- L'analyse statique passe (`flutter analyze`)
- Les tests passent (`flutter test`)
- La couverture reste ≥50%
