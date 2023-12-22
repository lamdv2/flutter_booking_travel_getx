import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan_clean_achitec/models/city/city_model.dart';
import 'package:doan_clean_achitec/models/tour/tour_model.dart';
import 'package:doan_clean_achitec/modules/home/home.dart';
import 'package:get/get.dart';

class FavoriteController extends GetxController {
  final getListTourFavourite = Rxn<List<TourModel>>([]);
  final getListDestination = Rxn<List<CityModel>>([]);

  @override
  void onInit() {
    getListTourModelFavourite();
    getListModelDestination();
    super.onInit();
  }

  void getListTourModelFavourite() {
    List<TourModel> tourList = [];
    String idUser = homeController.userModel.value?.id ?? "";

    getListTourFavourite.value = tourList;
  }

  void getListModelDestination() async {
    List<CityModel> desList = [];
    String idUser = homeController.userModel.value?.id ?? "";

    if (idUser.isNotEmpty) {
      try {
        CollectionReference tourFavoriteCollection = FirebaseFirestore.instance
            .collection('userModel')
            .doc(idUser)
            .collection('favourite');

        QuerySnapshot tourFavoriteSnapshot = await tourFavoriteCollection.get();

        List<String> idTourList = tourFavoriteSnapshot.docs
            .map((document) => document['idDes'] as String)
            .toList();

        final tourModelCollection =
            FirebaseFirestore.instance.collection('cityModel');

        final tourModelSnapshot = await tourModelCollection
            .where(FieldPath.documentId, whereIn: idTourList)
            .get();

        desList = tourModelSnapshot.docs
            .map((document) => CityModel.fromJson(document))
            .toList();

        for (var des in desList) {
          des.isFavourite = true;
        }

        getListDestination.value = desList;

        print('List of favorite tours retrieved successfully.');
      } catch (e) {
        print('Error getting favorite tours: $e');
      }
    } else {
      print('User is not logged in.');
    }
  }

  void setTourFavorite(String idTour) async {
    String idUser = homeController.userModel.value?.id ?? "";

    if (idUser.isNotEmpty) {
      CollectionReference tourFavoriteCollection = FirebaseFirestore.instance
          .collection('userModel')
          .doc(idUser)
          .collection('favourite');

      await tourFavoriteCollection.add({'idTour': idTour});
      getListTourModelFavourite();
      print('Tour added to favorites successfully.');
    } else {
      print('User is not logged in.');
    }
  }

  void setDesFavourite(String idDes) async {
    String idUser = homeController.userModel.value?.id ?? "";

    if (idUser.isNotEmpty) {
      CollectionReference tourFavoriteCollection = FirebaseFirestore.instance
          .collection('userModel')
          .doc(idUser)
          .collection('favourite');

      await tourFavoriteCollection.add({'idDes': idDes});
      getListModelDestination();
      // Get.snackbar("ok", 'Tour added to favorites successfully.');
    } else {
      // Get.snackbar("error", 'User is not logged in.');
    }
  }

  void removeDesFavourite(String idDes) async {
    String idUser = homeController.userModel.value?.id ?? "";

    if (idUser.isNotEmpty) {
      try {
        CollectionReference favouriteCollection = FirebaseFirestore.instance
            .collection('userModel')
            .doc(idUser)
            .collection('favourite');

        QuerySnapshot desSnapshot =
            await favouriteCollection.where('idDes', isEqualTo: idDes).get();

        if (desSnapshot.docs.isNotEmpty) {
          await favouriteCollection.doc(desSnapshot.docs.first.id).delete();

          getListModelDestination();
        } else {}
        // ignore: empty_catches
      } catch (e) {}
    }
  }

  bool isCheckFavourite(idCity) {
    for (CityModel city in getListDestination.value ?? []) {
      if (city.id == idCity) return true;
    }
    return false;
  }
}
