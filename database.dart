import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  final CollectionReference infos =
      FirebaseFirestore.instance.collection('blogs');
  Future get() async {
    List informations = [];
    try {
      await infos.get().then((value) {
        value.docs.forEach((element) {
          informations.add(element.data());
        });
      });
    } catch (e) {
      return null;
    }
  }
}
