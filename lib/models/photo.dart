import 'dart:io';

class Photo {
  final String id;
  final String name;
  final File image;

  Photo({required this.id, required this.name, required this.image});
}
