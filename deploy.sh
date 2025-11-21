#!/bin/bash

# Script de déploiement pour ShopFlutter
# Usage: ./deploy.sh [prod|preview]

set -e

echo "🚀 Déploiement de ShopFlutter"
echo "=============================="

# Build l'application Flutter
echo "📦 Building Flutter web app..."
flutter build web --release

# Détermine le type de déploiement
DEPLOY_TYPE=${1:-preview}

echo ""
echo "🌐 Déploiement sur Vercel ($DEPLOY_TYPE)..."

if [ "$DEPLOY_TYPE" = "prod" ]; then
    echo "🔴 Déploiement en PRODUCTION"
    vercel --prod --yes
else
    echo "🟡 Déploiement en PREVIEW"
    vercel --yes
fi

echo ""
echo "✅ Déploiement terminé !"
echo ""
echo "📊 URLs de déploiement :"
echo "  - Production: https://appecommerce-three.vercel.app"
echo "  - Firebase: https://app-ecommerce-flutter-eb6fe.web.app"
echo ""
echo "💡 Conseil: Utilisez './deploy.sh prod' pour déployer en production"
echo "           Utilisez './deploy.sh preview' (ou './deploy.sh') pour un preview"
