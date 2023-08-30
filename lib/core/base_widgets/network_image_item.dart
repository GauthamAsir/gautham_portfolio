import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gautham_portfolio/generated/assets.dart';

class NetworkImageItem extends StatelessWidget {
  final String imageUrl;
  final double radius;
  final BoxFit? boxFit;

  const NetworkImageItem(
    this.imageUrl, {
    super.key,
    this.radius = 10,
    this.boxFit,
  });

  @override
  Widget build(BuildContext context) {
    // print(BaseHttpClient.baseAssetUrl + imageUrl);
    return ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: FadeInImage(
            fadeInDuration: const Duration(milliseconds: 700),
            fadeOutDuration: const Duration(milliseconds: 700),
            placeholderFit: boxFit ?? BoxFit.scaleDown,
            fit: boxFit ?? BoxFit.contain,
            placeholderErrorBuilder: (e, s, _) {
              return Image.asset(
                Assets.imagesPlaceHolderImage,
                fit: BoxFit.cover,
              );
            },
            imageErrorBuilder: (context, e, s) {
              return Image.asset(
                Assets.imagesPlaceHolderImage,
                fit: BoxFit.cover,
              );
            },
            image: CachedNetworkImageProvider(
              imageUrl,
              // (imageUrl.contains("http"))
              //     ? imageUrl
              //     : BaseHttpClient.baseAssetUrl
              //         // "https://stylabs-mainstreet.s3.ap-south-1.amazonaws.com"
              //         +
              //         imageUrl,
            ),
            placeholder: const AssetImage(Assets.imagesPlaceHolderImage)));
    //     svg.Svg(
    //   "assets/images/Mnst-loader.svg",
    //   color: Colors.grey.shade300,
    // ),
    //     AssetImage(
    //   "assets/images/logo.png",
    // ),
    //   ),
    // ));
  }
}
