import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final _db = FirebaseFirestore.instance;
  CollectionReference get _namesCollection => _db.collection('names');
  List<String>? names;
  DocumentSnapshot? _lastFetchedNameDocument;

  Future<void> fetchNameDocuments() async {
    try {
      QuerySnapshot nameDocuments;

      ///Checking if names are null for loading purposes
      names ??= [];
      // if (names == null) {
      //   names = [];
      // }

      ///pagination logics
      if (_lastFetchedNameDocument == null) {
        print('hwllo2');
        nameDocuments = await _namesCollection.limit(5).get();
        // log('${nameDocuments.docs.last}');
      } else {
        nameDocuments = await _namesCollection
            .limit(5)
            .startAfterDocument(_lastFetchedNameDocument!)
            .get();
      }
      _lastFetchedNameDocument = nameDocuments.docs.last;

      ///Adding to existing list
      names!.addAll(
        nameDocuments.docs.map((document) {
          final jsonData = document.data() as Map<String, dynamic>;
          return jsonData['name'] as String;
        }).toList(),
      );
    } catch (e) {
      print(e);
      //
    }
  }

  @override
  void onInit() {
    fetchNameDocuments();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
