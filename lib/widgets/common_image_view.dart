import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommonImageView extends StatelessWidget {
  ///[url] is required parameter for fetching network image
  String? url;
  String? imagePath;
  String? svgPath;
  File? file;
  double? height;
  double? width;
  Color? color;
  final BoxFit fit;
  final String placeHolder;

  ///a [CommonNetworkImageView] it can be used for showing any network images
  /// it will shows the placeholder image if image is not found on network
  CommonImageView({
    super.key,
    this.url,
    this.imagePath,
    this.svgPath,
    this.file,
    this.height,
    this.width,
    this.color,
    this.fit = BoxFit.fill,
    this.placeHolder = 'assets/images/image_not_found.png',
  });

  @override
  Widget build(BuildContext context) {
    return _buildImageView();
  }

  Widget _buildImageView() {
    if (svgPath != null && svgPath!.isNotEmpty) {
      return SizedBox(
        height: height,
        width: width,
        child: SvgPicture.asset(
          svgPath!,
          height: height,
          width: width,
          fit: fit,
          color: color,
        ),
      );
    } else if (file != null && file!.path.isNotEmpty) {
      return Image.file(
        file!,
        height: height,
        width: width,
        fit: fit,
        color: color,
      );
    } else if (url != null && url!.isNotEmpty) {
      return ExtendedImage.network(
        url!,
        height: height,
        width: width,
        fit: fit,
        cache: true,
        cacheRawData: true,
        clearMemoryCacheIfFailed: true,
        enableLoadState: true,

        // placeholder: (context, url) => SizedBox(
        //   height: 200.h,
        //   // width: 30,
        //   child: LinearProgressIndicator(
        //     color: Colors.grey.shade200,
        //     backgroundColor: Colors.grey.shade100,
        //   ),
        // ),
        // errorWidget: (context, url, error) => Image.asset(
        //   placeHolder,
        //   height: height,
        //   width: width,
        //   fit: fit,
        //   color: Colors.white,
        // ),
      );
    } else if (imagePath != null && imagePath!.isNotEmpty) {
      return Image.asset(
        imagePath!,
        height: height,
        width: width,
        color: color,
        fit: fit,
      );
    }
    return const SizedBox();
  }
}
