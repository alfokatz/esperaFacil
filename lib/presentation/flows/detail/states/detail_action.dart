import 'package:template/domain/entities/photo.dart';

sealed class DetailAction {}

class Load extends DetailAction {
  final Photo photo;

  Load({required this.photo});
}

class Like extends DetailAction {
  final int like;

  Like({required this.like});
}

class Dislike extends DetailAction {
  final int dislike;

  Dislike({required this.dislike});
}
