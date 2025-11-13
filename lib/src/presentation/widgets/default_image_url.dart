import 'package:flutter/material.dart';

class DefaultImageUrl extends StatelessWidget {
  String? url;
  double width; 

  DefaultImageUrl({
    super.key, 
    this.url,
    this.width = 60,
  });

  bool _isValidUrl(String? url) {
    if (url == null || url.isEmpty || url == 'null') {
      return false;
    }
    try {
      final uri = Uri.parse(url);
      return uri.hasScheme && uri.host.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasValidUrl = _isValidUrl(url);
    
    return SizedBox(
      width: width,
      child: AspectRatio(
        aspectRatio: 1,
        child: ClipOval(
          child: hasValidUrl
              ? FadeInImage.assetNetwork(
                  placeholder: 'assets/img/user_image.png', 
                  image: url!,
                  fit: BoxFit.cover,
                  fadeInDuration: Duration(seconds: 1),
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/img/user_image.png',
                      fit: BoxFit.cover,
                    );
                  },
                )
              : Image.asset(
                  'assets/img/user_image.png',
                  fit: BoxFit.cover,
                )
        ),
      ),
    );
  }
}