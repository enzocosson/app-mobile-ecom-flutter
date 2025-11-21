import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/entities/cart_item.dart';
import 'product_image.dart';

/// Widget moderne pour afficher un item du panier
class CartItemCard extends StatelessWidget {
  final CartItem item;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;
  final VoidCallback? onRemove;

  const CartItemCard({
    super.key,
    required this.item,
    this.onIncrement,
    this.onDecrement,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final subtotal = item.product.price * item.quantity;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppTheme.cardShadow,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Dismissible(
          key: Key(item.product.id.toString()),
          direction: DismissDirection.endToStart,
          background: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.errorColor.withOpacity(0.8),
                  AppTheme.errorColor,
                ],
              ),
            ),
            child: const Icon(
              Icons.delete_outline,
              color: Colors.white,
              size: 32,
            ),
          ),
          confirmDismiss: (direction) async {
            return await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Confirmer la suppression'),
                  content: Text(
                    'Voulez-vous vraiment retirer "${item.product.title}" du panier ?',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text('Annuler'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      style: TextButton.styleFrom(
                        foregroundColor: AppTheme.errorColor,
                      ),
                      child: const Text('Supprimer'),
                    ),
                  ],
                );
              },
            );
          },
          onDismissed: (direction) => onRemove?.call(),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image du produit
                Hero(
                  tag: 'product-${item.product.id}',
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppTheme.backgroundColor,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: ProductImage(
                        imageUrl: item.product.thumbnail,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                
                // Informations produit
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Titre et bouton supprimer
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              item.product.title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.textPrimary,
                                height: 1.3,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            icon: const Icon(Icons.close),
                            iconSize: 20,
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            color: AppTheme.textTertiary,
                            onPressed: onRemove,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      
                      // Prix unitaire
                      Text(
                        '${item.product.price.toStringAsFixed(2)} € / unité',
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      
                      // Contrôles quantité et sous-total
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Contrôles quantité
                          Container(
                            decoration: BoxDecoration(
                              color: AppTheme.backgroundColor,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: AppTheme.primaryColor.withOpacity(0.2),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: onDecrement,
                                    borderRadius: const BorderRadius.horizontal(
                                      left: Radius.circular(10),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      child: Icon(
                                        item.quantity > 1
                                            ? Icons.remove
                                            : Icons.delete_outline,
                                        size: 20,
                                        color: item.quantity > 1
                                            ? AppTheme.primaryColor
                                            : AppTheme.errorColor,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.symmetric(
                                      vertical: BorderSide(
                                        color: AppTheme.primaryColor.withOpacity(0.2),
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    '${item.quantity}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme.textPrimary,
                                    ),
                                  ),
                                ),
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: onIncrement,
                                    borderRadius: const BorderRadius.horizontal(
                                      right: Radius.circular(10),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      child: const Icon(
                                        Icons.add,
                                        size: 20,
                                        color: AppTheme.primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          // Sous-total
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                'Sous-total',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: AppTheme.textTertiary,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '${subtotal.toStringAsFixed(2)} €',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 400.ms)
        .slideX(begin: 0.2, end: 0, curve: Curves.easeOut);
  }
}
