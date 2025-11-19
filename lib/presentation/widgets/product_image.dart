import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;

  const ProductImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  });

  IconData _getIconForProduct(String url) {
    final lowerUrl = url.toLowerCase();
    if (lowerUrl.contains('iphone') || lowerUrl.contains('smartphone')) {
      return Icons.phone_iphone;
    } else if (lowerUrl.contains('macbook') || lowerUrl.contains('laptop')) {
      return Icons.laptop_mac;
    } else if (lowerUrl.contains('samsung') || lowerUrl.contains('galaxy')) {
      return Icons.phone_android;
    } else if (lowerUrl.contains('headphone') ||
        lowerUrl.contains('airpod') ||
        lowerUrl.contains('audio') ||
        lowerUrl.contains('beats')) {
      return Icons.headphones;
    } else if (lowerUrl.contains('ipad') || lowerUrl.contains('tablet')) {
      return Icons.tablet_mac;
    } else if (lowerUrl.contains('dell') || lowerUrl.contains('xps')) {
      return Icons.computer;
    } else if (lowerUrl.contains('watch')) {
      return Icons.watch;
    } else if (lowerUrl.contains('camera') || lowerUrl.contains('canon')) {
      return Icons.camera_alt;
    } else if (lowerUrl.contains('pixel') || lowerUrl.contains('google')) {
      return Icons.smartphone;
    }
    return Icons.image;
  }

  Color _getColorForProduct(String url) {
    final lowerUrl = url.toLowerCase();
    if (lowerUrl.contains('iphone')) {
      return Colors.grey.shade800;
    } else if (lowerUrl.contains('macbook')) {
      return Colors.grey.shade700;
    } else if (lowerUrl.contains('samsung')) {
      return Colors.blue.shade700;
    } else if (lowerUrl.contains('sony') || lowerUrl.contains('beats')) {
      return Colors.black87;
    } else if (lowerUrl.contains('ipad')) {
      return Colors.grey.shade600;
    } else if (lowerUrl.contains('dell')) {
      return Colors.blue.shade800;
    } else if (lowerUrl.contains('airpod')) {
      return Colors.white;
    } else if (lowerUrl.contains('watch')) {
      return Colors.grey.shade800;
    } else if (lowerUrl.contains('canon')) {
      return Colors.black;
    } else if (lowerUrl.contains('pixel')) {
      return Colors.grey.shade700;
    }
    return Colors.grey.shade400;
  }

  @override
  Widget build(BuildContext context) {
    // Déterminer si c'est une URL ou un asset local
    final isAsset = imageUrl.startsWith('assets/');

    if (isAsset) {
      return Image.asset(
        imageUrl,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          final icon = _getIconForProduct(imageUrl);
          final color = _getColorForProduct(imageUrl);

          return Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [color.withOpacity(0.7), color.withOpacity(0.9)],
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              size: (width ?? height ?? 50) * 0.5,
              color: color == Colors.white
                  ? Colors.grey.shade800
                  : Colors.white,
            ),
          );
        },
      );
    }

    return Image.network(
      imageUrl,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        final icon = _getIconForProduct(imageUrl);
        final color = _getColorForProduct(imageUrl);

        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [color.withOpacity(0.7), color.withOpacity(0.9)],
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: (width ?? height ?? 50) * 0.5,
            color: color == Colors.white ? Colors.grey.shade800 : Colors.white,
          ),
        );
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          width: width,
          height: height,
          color: Colors.grey.shade200,
          child: Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                  : null,
            ),
          ),
        );
      },
    );
  }
}
