part of "providers.dart";

class KomentarData extends ChangeNotifier {
  final CollectionReference _komentarsCollection =
      FirebaseFirestore.instance.collection("komentars");

  CollectionReference get komentarsCollection {
    return _komentarsCollection;
  }

  Future<int> get komentarCount async {
    QuerySnapshot querySnapshot = await _komentarsCollection.get();
    return querySnapshot.size;
  }

  Future<int> get lastId async {
    QuerySnapshot querySnapshot =
        await _komentarsCollection.orderBy("tglDibuat", descending: true).get();
    if (querySnapshot.size == 0) {
      return 0;
    }
    return int.parse(querySnapshot.docs.first.get("id"));
  }

  void add(Komentar komentar) async {
    int id;
    if (komentarCount == 0) {
      id = await komentarCount + 1;
    } else {
      id = await lastId + 1;
    }

    _komentarsCollection.doc(id.toString()).set({
      "id": id.toString(),
      "tglDibuat": komentar.tglDibuat,
      "konten": komentar.konten,
      "postId": komentar.postId,
      "userId": komentar.userId,
      "likes": komentar.likes,
    });

    // tambahkan komentar pada post
    CollectionReference postsCollection =
        FirebaseFirestore.instance.collection("posts");
    QuerySnapshot posts =
        await postsCollection.where("id", isEqualTo: komentar.postId).get();
    List<String> komentars = List<String>.from(posts.docs[0].get("komentars"));
    komentars.add(id.toString());
    postsCollection.doc(komentar.postId).update({"komentars": komentars});
  }

  final List<String> _selectedKomentar = [];
  UnmodifiableListView get selectedKomentar {
    return UnmodifiableListView(_selectedKomentar);
  }

  void toggleSelectKomentar(String id) {
    if (_selectedKomentar.contains(id)) {
      _selectedKomentar.remove(id);
    } else {
      _selectedKomentar.add(id);
    }
    print(_selectedKomentar.length);
    // _selectedKomentar.clear();
    // notifyListeners();
  }

  void delete() async {
    // hapus komentar pada post
    CollectionReference postsCollection =
        FirebaseFirestore.instance.collection("posts");

    Komentar komentar = await getKomentar(_selectedKomentar[0]);
    for (int i = 0; i < _selectedKomentar.length; i++) {
      // hapus komentar dari collection komentars
      _komentarsCollection.doc(_selectedKomentar[i]).delete();
    }
    // hapus komentar dari collection posts
    QuerySnapshot posts =
        await postsCollection.where("id", isEqualTo: komentar.postId).get();
    List<String> komentars = List<String>.from(posts.docs[0].get("komentars"));
    komentars.removeWhere((komentar) => _selectedKomentar.contains(komentar));
    postsCollection.doc(komentar.postId).update({"komentars": komentars});

    _selectedKomentar.removeRange(1, _selectedKomentar.length);
  }

  Future<List<Komentar>> getKomentars({String? postId, String? userId}) async {
    QuerySnapshot? querySnapshot =
        await _komentarsCollection.where("postId", isEqualTo: postId).get();
    if (postId != null) {
      querySnapshot = await _komentarsCollection
          .where("postId", isEqualTo: postId)
          .orderBy("tglDibuat", descending: true)
          .get();
    } else if (userId != null) {
      querySnapshot = await _komentarsCollection
          .where("userId", isEqualTo: userId)
          .orderBy("tglDibuat", descending: true)
          .get();
    }

    List<Komentar> komentars = [];
    querySnapshot.docs.forEach((doc) {
      Komentar komentar = Komentar.fromJson(doc.data() as Map<String, dynamic>);
      komentar.likes = List<String>.from(doc.get("likes"));
      komentars.add(komentar);
    });

    return komentars;
  }

  Future<Komentar> getKomentar(String id) async {
    QuerySnapshot querySnapshot =
        await _komentarsCollection.where("id", isEqualTo: id).get();

    final komentars = querySnapshot.docs;

    Komentar? komentar =
        Komentar.fromJson(komentars[0].data() as Map<String, dynamic>);
    return komentar;
  }

  Future<int> getKomentarCount(int postId) async {
    QuerySnapshot? querySnapshot =
        await _komentarsCollection.where("postId", isEqualTo: postId).get();
    return querySnapshot.docs.length;
  }
}
