import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

import 'package:new_pokemon_app/generator/assets.gen.dart';

class HostedImage extends StatelessWidget {
  const HostedImage(
    this.url, {
    Key? key,
    this.height,
    this.width,
    this.fit = BoxFit.contain,
  }) : super(key: key);

  final String url;
  final double? height, width;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      fit: fit,
      height: height,
      width: width,
      progressIndicatorBuilder: (_, s, i) =>
          CupertinoActivityIndicator.partiallyRevealed(
        progress: i.progress ?? 1,
      ),
      errorWidget: (_, s, ____) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: LocalImage(Assets.images.appIcon.path),
      ),
      fadeInDuration: const Duration(seconds: 1),
    );
  }
}

class LocalImage extends StatelessWidget {
  const LocalImage(this.image,
      {Key? key, this.height, this.width, this.fit = BoxFit.contain})
      : super(key: key);
  final String image;
  final double? height, width;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      image,
      fit: fit,
      height: height,
      width: width,
    );
  }
}
