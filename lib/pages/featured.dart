import 'package:economic/components/loading.dart';
import 'package:economic/provider.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/components/carousel/gf_carousel.dart';
import 'package:provider/provider.dart';

class ImageCarousel extends StatefulWidget {
  @override
  _ImageCarouselState createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  List<String> photoUrl = [];

//  List<DocumentSnapshot> data = <DocumentSnapshot>[];
//
//  Future<List<DocumentSnapshot>> getSuggestions() => Firestore.instance
//          .collection(Common.Product)
//          .where('feature', isEqualTo: true)
//          .getDocuments()
//          .then((snap) {
//        return snap.documents;
//      });
//
//  _getCategories() async {
//    List<DocumentSnapshot> photosData = await getSuggestions();
//
//    for (int i = 0; i < photosData.length; i++) {
//      photoUrl.add(photosData[i].data['picture']);
//    }
//  }
//
//  @override
//  void initState() {
//    _getCategories();
//  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);

    for (int i = 0; i < user.photosData.length; i++) {
      photoUrl.add(user.photosData[i].data['picture']);
    }
    return photoUrl.isEmpty
        ? Center(
            child: Loading(),
          )
        : GFCarousel(
            autoPlay: true,
//            pagination: true,
//            activeIndicator: white,
            items: photoUrl.map(
              (url) {
                return Container(
                  margin: EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Image.network(url, fit: BoxFit.cover, width: 1000.0),
                  ),
                );
              },
            ).toList(),
            onPageChanged: (index) {
              setState(() {
                index;
              });
            },
          );
  }
}
