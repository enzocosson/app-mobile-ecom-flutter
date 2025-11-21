# 🎨 Design System - ShopFlutter

## Vue d'ensemble

Design moderne et professionnel pour ShopFlutter avec une palette de couleurs sophistiquée, des animations fluides et une expérience utilisateur optimisée.

---

## 🎨 Palette de couleurs

### Couleurs principales
- **Primary**: `#1E3A8A` (Bleu marine profond)
- **Secondary**: `#3B82F6` (Bleu moderne)
- **Accent**: `#06B6D4` (Cyan)
- **Background**: `#F8FAFC` (Gris très clair)
- **Surface**: `#FFFFFF` (Blanc)

### Couleurs fonctionnelles
- **Success**: `#10B981` (Vert)
- **Error**: `#EF4444` (Rouge)
- **Warning**: `#F59E0B` (Orange)

### Couleurs de texte
- **Primary**: `#0F172A` (Très sombre)
- **Secondary**: `#64748B` (Gris moyen)
- **Tertiary**: `#94A3B8` (Gris clair)

---

## 🎭 Gradients

### Primary Gradient
```dart
LinearGradient(
  colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
)
```

### Accent Gradient
```dart
LinearGradient(
  colors: [Color(0xFF3B82F6), Color(0xFF06B6D4)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
)
```

---

## 📝 Typographie

**Police**: **Inter** (via Google Fonts)

### Hiérarchie
- **Display Large**: 32px, Bold
- **Display Medium**: 28px, Bold
- **Display Small**: 24px, Bold
- **Headline Large**: 22px, SemiBold
- **Headline Medium**: 20px, SemiBold
- **Headline Small**: 18px, SemiBold
- **Title Large**: 16px, SemiBold
- **Body Large**: 16px, Regular
- **Body Medium**: 14px, Regular
- **Body Small**: 12px, Regular

---

## 🧩 Composants

### ProductCard
- **Effet hover** avec élévation animée
- **Badge catégorie** avec gradient
- **Badge rating** avec étoile
- **Image** avec chargement progressif
- **Animations** d'entrée (fadeIn + slideY)

**Caractéristiques**:
- Border radius: 16px
- Shadow: Légère (élévation 0 → 8px au hover)
- Transition: 200ms

### CartItemCard
- **Swipe to delete** avec confirmation
- **Contrôles quantité** modernes
- **Hero animation** pour l'image
- **Sous-total** affiché en temps réel

**Caractéristiques**:
- Border radius: 16px
- Padding: 12px
- Animation d'entrée: fadeIn + slideX

### HomeScreen
- **AppBar** avec logo gradient
- **Header** avec gradient et statistiques
- **Grille responsive** (2 colonnes)
- **États** animés (loading, error, empty)

### CartScreen
- **Liste scrollable** d'items
- **Résumé** dans un container flottant
- **Total** avec effet gradient (ShaderMask)
- **Bouton CTA** proéminent

---

## ✨ Animations

### Flutter Animate
- **fadeIn**: 400ms avec delay 100ms
- **slideY**: Translation verticale (0.2 → 0)
- **slideX**: Translation horizontale (0.2 → 0)
- **shimmer**: Effet de brillance sur le loading

### Transitions
- **Hover**: 200ms
- **Page**: Default (Material)
- **Hero**: Pour les images produits

---

## 🎯 Bonnes pratiques

### Espacement
- **Petit**: 8px
- **Moyen**: 16px
- **Grand**: 24px
- **XL**: 32px

### Border Radius
- **Petit**: 8px
- **Moyen**: 12px
- **Grand**: 16px
- **XL**: 20px

### Ombres
```dart
// Card Shadow
BoxShadow(
  color: Colors.black.withOpacity(0.05),
  blurRadius: 10,
  offset: Offset(0, 4),
)

// Elevated Shadow
BoxShadow(
  color: Colors.black.withOpacity(0.1),
  blurRadius: 20,
  offset: Offset(0, 8),
)
```

---

## 📱 Responsive

### Breakpoints
- **Mobile**: < 600px
- **Tablet**: 600px - 1024px
- **Desktop**: > 1024px

### Grille produits
- **Mobile**: 2 colonnes
- **Tablet**: 3 colonnes (à implémenter)
- **Desktop**: 4 colonnes (à implémenter)

---

## 🚀 Utilisation

### Thème
```dart
MaterialApp(
  theme: AppTheme.lightTheme,
  // ...
)
```

### Couleurs
```dart
import 'package:app_ecommerce/core/theme/app_theme.dart';

Container(
  color: AppTheme.primaryColor,
  // ou
  decoration: BoxDecoration(
    gradient: AppTheme.primaryGradient,
  ),
)
```

### Composants
```dart
// ProductCard
ProductCard(product: product)

// CartItemCard
CartItemCard(
  item: item,
  onIncrement: () {},
  onDecrement: () {},
  onRemove: () {},
)
```

---

## 📦 Dépendances

```yaml
dependencies:
  google_fonts: ^6.2.1    # Typographie
  flutter_animate: ^4.5.0  # Animations
```

---

## 🎬 Effets visuels

### Gradient sur texte
```dart
ShaderMask(
  shaderCallback: (bounds) => AppTheme.primaryGradient.createShader(bounds),
  child: Text(
    'ShopFlutter',
    style: TextStyle(color: Colors.white),
  ),
)
```

### Container avec ombre
```dart
Container(
  decoration: BoxDecoration(
    color: AppTheme.surfaceColor,
    borderRadius: BorderRadius.circular(16),
    boxShadow: AppTheme.cardShadow,
  ),
)
```

---

## 🔄 Prochaines améliorations

- [ ] Dark mode
- [ ] Animations de transition entre pages
- [ ] Skeleton loading
- [ ] Micro-interactions (boutons, inputs)
- [ ] Thème personnalisable par l'utilisateur
- [ ] Responsive design pour tablettes et desktop
- [ ] Glassmorphism pour certains composants
- [ ] Animations Lottie pour les états vides

---

## 📸 Screenshots

*À ajouter: captures d'écran de l'application*

---

**Design créé avec** ❤️ **par l'équipe ShopFlutter**
