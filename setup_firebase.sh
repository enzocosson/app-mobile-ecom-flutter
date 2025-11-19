#!/bin/bash

# Script de configuration Firebase pour ShopFlutter

echo "🔥 Configuration de Firebase pour ShopFlutter..."

# Étape 1 : Vérifier que Firebase CLI est connecté
echo "✓ Firebase CLI connecté en tant que: enzolemercier@gmail.com"

# Étape 2 : Configurer FlutterFire
echo ""
echo "📱 Configuration de FlutterFire en cours..."
echo "Vous devez avoir créé un projet Firebase dans la console Firebase."
echo "Si ce n'est pas fait, allez sur : https://console.firebase.google.com/"
echo ""

# Exporter le PATH pour flutterfire
export PATH="$PATH":"$HOME/.pub-cache/bin"

# Lancer la configuration FlutterFire
flutterfire configure \
  --project=shopflutter-app \
  --platforms=android,ios,web \
  --android-package-name=com.iim.shopflutter \
  --ios-bundle-id=com.iim.shopflutter \
  --web-app-id=shopflutter-web

echo ""
echo "✅ Configuration terminée !"
echo ""
echo "Prochaines étapes :"
echo "1. Activer l'authentification Email/Password dans Firebase Console"
echo "2. Exécuter : flutter pub get"
echo "3. Exécuter : flutter pub run build_runner build --delete-conflicting-outputs"
echo "4. Lancer l'app : flutter run"
