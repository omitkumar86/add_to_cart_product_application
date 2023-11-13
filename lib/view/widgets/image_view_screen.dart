import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ViewImageScreen extends StatelessWidget {
  final String? imageUrl;
  ViewImageScreen({this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: InkWell(
        onTap: (){
          Navigator.pop(context);
        },
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: PhotoView(
             minScale: 0.4,
              maxScale: 3.0,
              imageProvider: CachedNetworkImageProvider(imageUrl!),
            ),
          ),
        ),
      ),
    );
  }
}