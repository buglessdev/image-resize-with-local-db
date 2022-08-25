import 'package:flutter/material.dart';
import './add_photo_screen.dart';
import '../providers/photos.dart';
import 'package:provider/provider.dart';
import './photo_detail_screen.dart';

class PhotosList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Photos'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPhotoScreen.routeName);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<Photos>(context, listen: false).fetchAndSetPhotos(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<Photos>(
                child: const Center(
                  child: Text('No photos added yet'),
                ),
                builder: (ctx, photos, child) => photos.items.length <= 0
                    ? child!
                    : ListView.builder(
                        itemCount: photos.items.length,
                        itemBuilder: (ctx, i) => ListTile(
                          leading: CircleAvatar(
                            backgroundImage: FileImage(photos.items[i].image),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              Provider.of<Photos>(context, listen: false)
                                  .deletePhoto(photos.items[i].id);
                            },
                          ),
                          title: Text(photos.items[i].name),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) =>
                                    PhotoDetailScreen(photos.items[i].id)));
                          },
                        ),
                      ),
              ),
      ),
    );
  }
}
