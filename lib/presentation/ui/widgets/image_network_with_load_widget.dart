import 'dart:io';
import 'package:doublevpartners/utils/images_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ImageNetworkWithLoadWidget extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? width;
  final BoxFit fit;
  final String? defaultImage;

  const ImageNetworkWithLoadWidget(
    this.imageUrl, {
    super.key,
    this.height,
    this.width,
    this.defaultImage,
    this.fit = BoxFit.cover,
  });

  _isWeb() {
    return imageUrl.startsWith('http') || imageUrl.startsWith('https');
  }

  _isLocal() {
    return imageUrl.startsWith('assets/') ||
        imageUrl.startsWith('file:') ||
        imageUrl.startsWith('blob:');
  }

  @override
  Widget build(BuildContext context) {
    return Image(
      image:
          _isWeb()
              ? NetworkImage(imageUrl)
              : (_isLocal() ? AssetImage(imageUrl) : FileImage(File(imageUrl))),
      fit: fit,
      width: width,
      height: height,
      errorBuilder: (context, error, stackTrace) {
        if (defaultImage != null) {
          return Image.asset(
            defaultImage!,
            height: height ?? 250,
            fit: fit,
            width: width ?? double.infinity,
          );
        }
        return SvgPicture.asset(
          ImagesConstants.imageNotFound,
          height: height ?? 250,
          fit: fit,
          width: width ?? double.infinity,
        );
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return SizedBox(
          height: height,
          width: width,
          child: Container(
            color: Colors.grey[200],
            child: const Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}
