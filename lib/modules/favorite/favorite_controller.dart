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

  void getListTourModelFavourite() async {
    List<TourModel> tourList = [];
    String idUser = homeController.userModel.value?.id ?? "";
    if (idUser.isNotEmpty) {
      try {
        CollectionReference tourFavoriteCollection = FirebaseFirestore.instance
            .collection('userModel')
            .doc(idUser)
            .collection('favouriteTour');

        QuerySnapshot tourFavoriteSnapshot = await tourFavoriteCollection.get();

        List<String> idTourList = tourFavoriteSnapshot.docs
            .map((document) => document['idTour'] as String)
            .toList();

        final tourModelCollection =
            FirebaseFirestore.instance.collection('tourModel');

        final tourModelSnapshot = await tourModelCollection
            .where(FieldPath.documentId, whereIn: idTourList)
            .get();

        tourList = tourModelSnapshot.docs
            .map((document) => TourModel.fromJson(document))
            .toList();

        for (TourModel tour in tourList) {
          tour.isFavourite = true;
        }

        getListTourFavourite.value = tourList;

        print('List of favorite tours retrieved successfully.');
      } catch (e) {
        print('Error getting favorite tours: $e');
      }
    } else {
      print('User is not logged in.');
    }
  }

  void getListModelDestination() async {
    List<CityModel> desList = [];
    String idUser = homeController.userModel.value?.id ?? "";

    if (idUser.isNotEmpty) {
      try {
        CollectionReference desFavoriteCollection = FirebaseFirestore.instance
            .collection('userModel')
            .doc(idUser)
            .collection('favourite');

        QuerySnapshot tourFavoriteSnapshot = await desFavoriteCollection.get();

        List<String> idDesList = tourFavoriteSnapshot.docs
            .map((document) => document['idDes'] as String)
            .toList();

        final tourModelCollection =
            FirebaseFirestore.instance.collection('cityModel');

        final desModelSnapshot = await tourModelCollection
            .where(FieldPath.documentId, whereIn: idDesList)
            .get();

        desList = desModelSnapshot.docs
            .map((document) => CityModel.fromJson(document))
            .toList();

        for (CityModel city in desList) {
          city.isFavourite = true;
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
          .collection('favouriteTour');

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

  void removeTourFavourite(String idTour) async {
    String idUser = homeController.userModel.value?.id ?? "";

    if (idUser.isNotEmpty) {
      try {
        CollectionReference favouriteCollection = FirebaseFirestore.instance
            .collection('userModel')
            .doc(idUser)
            .collection('favouriteTour');

        QuerySnapshot desSnapshot =
            await favouriteCollection.where('idTour', isEqualTo: idTour).get();

        if (desSnapshot.docs.isNotEmpty) {
          await favouriteCollection.doc(desSnapshot.docs.first.id).delete();

          getListTourModelFavourite();
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

  bool isCheckFavouriteTour(idTour) {
    for (TourModel tour in getListTourFavourite.value ?? []) {
      if (tour.idTour == idTour) return true;
    }
    return false;
  }
}
