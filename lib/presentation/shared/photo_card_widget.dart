import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:template/domain/entities/photo.dart';

import '../base/theme/app_dimens.dart';
import '../base/theme/app_images.dart';

class PhotoCardWidget extends StatelessWidget {
  late Photo _photo;
  Function(Photo)? _onClick;

  PhotoCardWidget({super.key, required Photo photo, Function(Photo)? onClick}) {
    _photo = photo;
    _onClick = onClick;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Material(
          child: InkWell(
            highlightColor: Theme.of(context).colorScheme.primary,
            onTap: () => _onClick?.call(_photo),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppDimens.smallMargin),
              ),
              elevation: AppDimens.elevationMedium,
              shadowColor: Theme.of(context).colorScheme.primary,
              child: Column(
                children: [
                  _buildImage(),
                  PhotoTitleWidget(photo: _photo),
                  _AlbumWidget(photo: _photo),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(AppDimens.smallMargin),
        topLeft: Radius.circular(AppDimens.smallMargin),
      ),
      clipBehavior: Clip.antiAlias,
      child: FadeInImage(
        height: 200,
        width: double.infinity,
        image: NetworkImage(_photo.url, scale: 1),
        placeholder: AppImages.placeholderImage,
        imageErrorBuilder:
            (context, error, _) => Container(child: AppImages.notPhoto()),
        fit: BoxFit.cover,
      ),
    );
  }
}

class PhotoTitleWidget extends StatelessWidget {
  const PhotoTitleWidget({super.key, required Photo photo}) : _photo = photo;

  final Photo _photo;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      margin: const EdgeInsets.symmetric(
        horizontal: AppDimens.smallMargin,
        vertical: AppDimens.mediumMargin,
      ),
      child: Text(_photo.title, style: Theme.of(context).textTheme.titleMedium),
    );
  }
}

class _AlbumWidget extends StatelessWidget {
  const _AlbumWidget({super.key, required Photo photo}) : _photo = photo;

  final Photo _photo;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      margin: const EdgeInsets.only(
        right: AppDimens.smallMargin,
        left: AppDimens.smallMargin,
        bottom: AppDimens.smallMargin,
      ),
      child: Row(
        children: [
          Text(
            'album'.tr(args: [_photo.albumId.toString()]),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              child: ZoomIn(
                delay: const Duration(milliseconds: 250),
                child: Icon(Icons.photo_camera_outlined),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
