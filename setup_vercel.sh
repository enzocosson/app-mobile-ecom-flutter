#!/bin/bash

# 🔧 Script de configuration Vercel automatique
# Ce script vous guide dans la configuration complète

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🚀 Configuration Vercel + GitHub CI/CD"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Couleurs
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Vérifier si Vercel CLI est installé
if ! command -v vercel &> /dev/null; then
    echo -e "${YELLOW}⚠️  Vercel CLI n'est pas installé${NC}"
    echo ""
    read -p "Voulez-vous installer Vercel CLI maintenant? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "📦 Installation de Vercel CLI..."
        npm install -g vercel
        echo -e "${GREEN}✅ Vercel CLI installé${NC}"
    else
        echo -e "${RED}❌ Vercel CLI est requis. Installation annulée.${NC}"
        exit 1
    fi
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Étape 1 : Connexion à Vercel"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

vercel login

echo ""
echo -e "${GREEN}✅ Connecté à Vercel${NC}"
echo ""

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Étape 2 : Liaison du projet"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Supprimer .vercel si existe pour forcer la reconfiguration
if [ -d ".vercel" ]; then
    echo "⚠️  Dossier .vercel existant trouvé"
    read -p "Voulez-vous reconfigurer? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        rm -rf .vercel
        echo "🗑️  Configuration précédente supprimée"
    fi
fi

echo ""
echo "🔗 Liaison du projet avec Vercel..."
echo ""
echo "Répondez aux questions suivantes:"
echo "  - Set up and deploy: N (non)"
echo "  - Link to existing project: Y (oui) si projet existe, sinon N"
echo "  - Project name: app-ecommerce-flutter (ou votre choix)"
echo ""

vercel link

echo ""
echo -e "${GREEN}✅ Projet lié à Vercel${NC}"
echo ""

# Vérifier si .vercel/project.json existe
if [ ! -f ".vercel/project.json" ]; then
    echo -e "${RED}❌ Erreur: .vercel/project.json n'a pas été créé${NC}"
    exit 1
fi

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Étape 3 : Récupération des IDs"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Extraire les IDs
ORG_ID=$(cat .vercel/project.json | grep -o '"orgId": *"[^"]*"' | cut -d'"' -f4)
PROJECT_ID=$(cat .vercel/project.json | grep -o '"projectId": *"[^"]*"' | cut -d'"' -f4)

if [ -z "$ORG_ID" ] || [ -z "$PROJECT_ID" ]; then
    echo -e "${RED}❌ Impossible de récupérer les IDs${NC}"
    exit 1
fi

echo -e "${GREEN}✅ IDs récupérés:${NC}"
echo ""
echo "  VERCEL_ORG_ID:     $ORG_ID"
echo "  VERCEL_PROJECT_ID: $PROJECT_ID"
echo ""

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Étape 4 : Génération du Token"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

echo "📝 Pour générer un token Vercel:"
echo ""
echo "  1. Ouvrez: https://vercel.com/account/tokens"
echo "  2. Cliquez sur 'Create Token'"
echo "  3. Nom: GitHub Actions CI/CD"
echo "  4. Scope: Full Account"
echo "  5. Expiration: No Expiration"
echo "  6. Cliquez sur 'Create'"
echo "  7. COPIEZ le token (il ne sera affiché qu'une fois)"
echo ""

read -p "Appuyez sur Entrée quand vous êtes prêt à ouvrir le navigateur..."

# Ouvrir le navigateur
if [[ "$OSTYPE" == "darwin"* ]]; then
    open "https://vercel.com/account/tokens"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    xdg-open "https://vercel.com/account/tokens"
else
    echo "Ouvrez manuellement: https://vercel.com/account/tokens"
fi

echo ""
read -p "Collez votre VERCEL_TOKEN ici: " VERCEL_TOKEN
echo ""

if [ -z "$VERCEL_TOKEN" ]; then
    echo -e "${RED}❌ Token vide. Configuration annulée.${NC}"
    exit 1
fi

echo -e "${GREEN}✅ Token récupéré${NC}"
echo ""

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Étape 5 : Configuration GitHub Secrets"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Récupérer l'URL du repo
REPO_URL=$(git config --get remote.origin.url)
if [ -z "$REPO_URL" ]; then
    echo -e "${YELLOW}⚠️  Impossible de détecter l'URL du repo${NC}"
    read -p "Entrez l'URL GitHub (ex: github.com/user/repo): " REPO_URL
fi

# Extraire owner/repo
if [[ $REPO_URL =~ github\.com[:/]([^/]+)/([^/.]+) ]]; then
    OWNER="${BASH_REMATCH[1]}"
    REPO="${BASH_REMATCH[2]}"
    SETTINGS_URL="https://github.com/$OWNER/$REPO/settings/secrets/actions"
else
    echo -e "${YELLOW}⚠️  Format d'URL non reconnu${NC}"
    SETTINGS_URL="https://github.com/settings/secrets/actions"
fi

echo "📝 Ajoutez ces secrets dans GitHub:"
echo ""
echo "  URL: $SETTINGS_URL"
echo ""
echo "  Secrets à créer:"
echo "  ┌────────────────────┬─────────────────────────────────────┐"
echo "  │ Nom                │ Valeur                              │"
echo "  ├────────────────────┼─────────────────────────────────────┤"
echo "  │ VERCEL_TOKEN       │ $VERCEL_TOKEN"
echo "  │ VERCEL_ORG_ID      │ $ORG_ID"
echo "  │ VERCEL_PROJECT_ID  │ $PROJECT_ID"
echo "  └────────────────────┴─────────────────────────────────────┘"
echo ""

read -p "Appuyez sur Entrée pour ouvrir la page des secrets GitHub..."

# Ouvrir le navigateur
if [[ "$OSTYPE" == "darwin"* ]]; then
    open "$SETTINGS_URL"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    xdg-open "$SETTINGS_URL"
else
    echo "Ouvrez manuellement: $SETTINGS_URL"
fi

echo ""
echo "Instructions:"
echo "  1. Cliquez sur 'New repository secret'"
echo "  2. Ajoutez chaque secret (nom EXACTEMENT comme indiqué)"
echo "  3. Copiez/collez la valeur correspondante"
echo "  4. Cliquez sur 'Add secret'"
echo "  5. Répétez pour les 3 secrets"
echo ""

read -p "Avez-vous ajouté les 3 secrets? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${YELLOW}⚠️  N'oubliez pas d'ajouter les secrets avant de pusher!${NC}"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Étape 6 : Sauvegarde des informations"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Créer un fichier .vercel.env pour référence (ne pas commit!)
cat > .vercel.env << EOF
# ⚠️  NE PAS COMMITER CE FICHIER - Ajouté à .gitignore
# Informations de configuration Vercel

VERCEL_TOKEN=$VERCEL_TOKEN
VERCEL_ORG_ID=$ORG_ID
VERCEL_PROJECT_ID=$PROJECT_ID

# Ces valeurs doivent être ajoutées comme secrets GitHub:
# https://github.com/settings/secrets/actions
EOF

echo -e "${GREEN}✅ Informations sauvegardées dans .vercel.env${NC}"
echo -e "${YELLOW}⚠️  Ce fichier est dans .gitignore (ne sera pas committé)${NC}"
echo ""

# Ajouter .vercel.env à .gitignore si pas déjà présent
if ! grep -q ".vercel.env" .gitignore 2>/dev/null; then
    echo ".vercel.env" >> .gitignore
    echo "✅ .vercel.env ajouté à .gitignore"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ Configuration terminée!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

echo "📋 Récapitulatif:"
echo ""
echo "  ✅ Vercel CLI installé et connecté"
echo "  ✅ Projet lié à Vercel"
echo "  ✅ IDs récupérés"
echo "  ✅ Token généré"
echo "  ✅ Configuration sauvegardée"
echo ""

echo "🚀 Prochaines étapes:"
echo ""
echo "  1. Vérifiez que les 3 secrets sont bien ajoutés dans GitHub"
echo "  2. Testez avec une Pull Request:"
echo ""
echo "     git checkout -b test/vercel-deploy"
echo "     git add ."
echo "     git commit -m 'Test Vercel deployment'"
echo "     git push origin test/vercel-deploy"
echo ""
echo "  3. Créez une PR sur GitHub"
echo "  4. Attendez le déploiement automatique (3-5 min)"
echo "  5. L'URL de preview sera commentée sur la PR"
echo ""

echo "📖 Documentation:"
echo "  - DEPLOYMENT_GUIDE.md - Guide complet"
echo "  - DEPLOYMENT_QUICK.md - Référence rapide"
echo "  - CI_CD_ARCHITECTURE.md - Architecture"
echo ""

echo -e "${GREEN}🎉 Tout est prêt pour le déploiement automatique!${NC}"
echo ""
