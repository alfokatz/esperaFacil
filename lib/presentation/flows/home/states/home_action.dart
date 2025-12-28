import 'package:template/domain/entities/photo.dart';

sealed class HomeAction {}

class LoadAction extends HomeAction {
  final List<Photo> photos;

  LoadAction({this.photos = const []});
}
