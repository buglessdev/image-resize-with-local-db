import 'package:flutter/foundation.dart';
import '../models/photo.dart';
import 'dart:io';
import '../helpers/db_helpers.dart';
import 'package:path/path.dart' as path;

class Photos with ChangeNotifier {
  List<Photo> _items = [];
  List<Photo> get items {
    return [..._items];
  }

  void addPhoto(String pickedName, File photo) {
    final newPhoto =
        Photo(id: DateTime.now().toString(), image: photo, name: pickedName);
    _items.add(newPhoto);
    notifyListeners();
    DBHelper.insert('photos', {
      'id': newPhoto.id,
      'name': newPhoto.name,
      'image': newPhoto.image.path
    });
  }

  Future<void> fetchAndSetPhotos() async {
    final dataList = await DBHelper.getData('photos');
    _items = dataList
        .map((item) => Photo(
            id: item['id'], name: item['name'], image: File(item['image'])))
        .toList();
    notifyListeners();
  }

  Future<void> deletePhoto(String id) async {
    _items.removeWhere((item) {
      if (item.id == id) {
        item.image.deleteSync();
      }
      return item.id == id;
    });
    print(_items);
    notifyListeners();
    DBHelper.delete('photos', id);
  }
}
