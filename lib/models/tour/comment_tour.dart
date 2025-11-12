import 'package:cloud_firestore/cloud_firestore.dart';

class CommentTour {
  String username;
  String comment;
  // ignore: prefer_typing_uninitialized_variables
  final datePublished;
  List likes;
  String profilePhoto;
  String uid;
  String id;

  CommentTour({
    required this.username,
    required this.comment,
    required this.datePublished,
    required this.likes,
    required this.profilePhoto,
    required this.uid,
    required this.id,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'comment': comment,
        'datePublished': datePublished,
        'likes': likes,
        'profilePhoto': profilePhoto,
        'uid': uid,
        'id': id,
      };

  static CommentTour fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return CommentTour(
      username: snapshot['username'],
      comment: snapshot['comment'],
      datePublished: snapshot['datePublished'],
      likes: snapshot['likes'],
      profilePhoto: snapshot['profilePhoto'],
      uid: snapshot['uid'],
      id: snapshot['id'],
    );
  }
}
