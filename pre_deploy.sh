#!/bin/bash

# 🚀 Script de pré-déploiement
# Ce script vérifie que tout est prêt avant de pusher sur GitHub

set -e  # Arrêter si une commande échoue

echo "🔍 Vérification pré-déploiement..."
echo ""

# Couleurs
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Fonction pour afficher les erreurs
error() {
    echo -e "${RED}❌ $1${NC}"
    exit 1
}

# Fonction pour afficher les succès
success() {
    echo -e "${GREEN}✅ $1${NC}"
}

# Fonction pour afficher les warnings
warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

# 1. Vérifier que Flutter est installé
echo "1️⃣  Vérification de Flutter..."
if ! command -v flutter &> /dev/null; then
    error "Flutter n'est pas installé ou pas dans le PATH"
fi
success "Flutter est installé"
echo ""

# 2. Vérifier la version de Flutter
echo "2️⃣  Vérification de la version Flutter..."
FLUTTER_VERSION=$(flutter --version | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' | head -1)
echo "   Version Flutter: $FLUTTER_VERSION"
success "Version Flutter OK"
echo ""

# 3. Nettoyer le projet
echo "3️⃣  Nettoyage du projet..."
flutter clean > /dev/null 2>&1
success "Projet nettoyé"
echo ""

# 4. Récupérer les dépendances
echo "4️⃣  Installation des dépendances..."
if ! flutter pub get; then
    error "Échec de l'installation des dépendances"
fi
success "Dépendances installées"
echo ""

# 5. Générer le code
echo "5️⃣  Génération du code..."
if ! flutter pub run build_runner build --delete-conflicting-outputs; then
    error "Échec de la génération du code"
fi
success "Code généré"
echo ""

# 6. Vérifier le formatage
echo "6️⃣  Vérification du formatage..."
if ! flutter format --set-exit-if-changed lib test > /dev/null 2>&1; then
    warning "Le code n'est pas correctement formaté"
    echo "   Exécutez: flutter format lib test"
    read -p "   Voulez-vous formater automatiquement? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        flutter format lib test
        success "Code formaté"
    else
        error "Formatage requis avant le déploiement"
    fi
else
    success "Formatage OK"
fi
echo ""

# 7. Analyser le code
echo "7️⃣  Analyse statique du code..."
if ! flutter analyze --no-fatal-infos; then
    error "L'analyse du code a échoué"
fi
success "Analyse du code OK"
echo ""

# 8. Exécuter les tests
echo "8️⃣  Exécution des tests..."
if ! flutter test; then
    error "Les tests ont échoué"
fi
success "Tests passés"
echo ""

# 9. Build Web
echo "9️⃣  Build Web..."
if ! flutter build web --release --web-renderer html; then
    error "Le build web a échoué"
fi
success "Build Web OK"
echo ""

# 10. Vérifier la taille du build
echo "🔟 Vérification de la taille du build..."
BUILD_SIZE=$(du -sh build/web | cut -f1)
echo "   Taille du build: $BUILD_SIZE"
success "Build généré"
echo ""

# 11. Vérifier les fichiers critiques
echo "1️⃣1️⃣  Vérification des fichiers critiques..."
CRITICAL_FILES=(
    "build/web/index.html"
    "build/web/main.dart.js"
    "build/web/manifest.json"
    "build/web/flutter.js"
)

for file in "${CRITICAL_FILES[@]}"; do
    if [ ! -f "$file" ]; then
        error "Fichier manquant: $file"
    fi
done
success "Fichiers critiques présents"
echo ""

# 12. Vérifier les secrets GitHub (optionnel)
echo "1️⃣2️⃣  Vérification des secrets GitHub..."
if [ -f ".github/workflows/flutter.yml" ]; then
    success "Workflow GitHub Actions trouvé"
    echo ""
    echo "   📝 Secrets requis dans GitHub:"
    echo "   - VERCEL_TOKEN"
    echo "   - VERCEL_ORG_ID"
    echo "   - VERCEL_PROJECT_ID"
    echo ""
    read -p "   Les secrets sont-ils configurés dans GitHub? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        warning "N'oubliez pas de configurer les secrets GitHub!"
        echo "   Voir DEPLOYMENT_GUIDE.md pour les instructions"
    fi
else
    warning "Workflow GitHub Actions non trouvé"
fi
echo ""

# 13. Vérifier l'espace disque
echo "1️⃣3️⃣  Vérification de l'espace disque..."
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    DISK_USAGE=$(df -h . | tail -1 | awk '{print $5}' | sed 's/%//')
    if [ "$DISK_USAGE" -gt 90 ]; then
        warning "Espace disque faible: ${DISK_USAGE}% utilisé"
        echo "   Considérez exécuter: flutter clean"
    else
        success "Espace disque OK (${DISK_USAGE}% utilisé)"
    fi
else
    # Linux
    DISK_USAGE=$(df -h . | tail -1 | awk '{print $5}' | sed 's/%//')
    if [ "$DISK_USAGE" -gt 90 ]; then
        warning "Espace disque faible: ${DISK_USAGE}% utilisé"
    else
        success "Espace disque OK (${DISK_USAGE}% utilisé)"
    fi
fi
echo ""

# 14. Vérifier Git
echo "1️⃣4️⃣  Vérification Git..."
if [ -n "$(git status --porcelain)" ]; then
    warning "Il y a des modifications non commitées"
    git status --short
    echo ""
    read -p "   Voulez-vous continuer? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        error "Commitez vos modifications avant de déployer"
    fi
else
    success "Aucune modification en attente"
fi
echo ""

# 15. Récapitulatif
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🎉 Toutes les vérifications sont passées!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "📦 Informations du build:"
echo "   - Taille: $BUILD_SIZE"
echo "   - Flutter: $FLUTTER_VERSION"
echo "   - Espace disque: ${DISK_USAGE}%"
echo ""
echo "🚀 Prêt pour le déploiement!"
echo ""
echo "Prochaines étapes:"
echo "   1. git add ."
echo "   2. git commit -m 'Your message'"
echo "   3. git push origin develop  (pour preview)"
echo "   4. git push origin main      (pour production)"
echo ""
echo "📖 Voir DEPLOYMENT_GUIDE.md pour plus d'infos"
echo ""
