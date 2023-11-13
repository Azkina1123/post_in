part of "providers.dart";

class PostData extends ChangeNotifier {
  // final List<Post> _postsRef = [
  //   Post(
  //     id: 1,
  //     tglDibuat: DateTime.utc(2023, 5, 22, 7, 00),
  //     konten:
  //         "Selamat ulang tahun yang ke-25, [nama teman]! Semoga hari ini penuh kebahagiaan dan keberuntungan. Semoga semua impianmu terwujud. 🎂🎉, #UlangTahun #TemanTerbaik",
  //     userId: 3,
  //     totalKomentar: 2,
  //     totalLike: 0,
  //   ),
  //   Post(
  //     id: 2,
  //     tglDibuat: DateTime.utc(2023, 5, 30, 23, 12),
  //     konten:
  //         "Hari pertama liburan di [nama destinasi]! Pemandangan luar biasa dan cuaca cerah. Bersama [nama teman/keluarga] siap menjelajahi petualangan ini. 🏝️☀️ #LiburanSeru #Petualangan",
  //     userId: 1,
  //     img: NetworkImage("https://picsum.photos/800/500"),
  //     totalKomentar: 2,
  //     totalLike: 0,
  //   ),
  //   Post(
  //     id: 3,
  //     tglDibuat: DateTime.utc(2023, 8, 2, 17, 54),
  //     konten:
  //         "Cuaca cerah hari ini, matahari bersinar terang! Semoga hari ini penuh semangat. ☀️ #CuacaBagus #Semangat",
  //     userId: 2,
  //     totalKomentar: 1,
  //     totalLike: 0,
  //   ),
  //   Post(
  //     id: 4,
  //     tglDibuat: DateTime.utc(2023, 10, 11, 11, 22),
  //     konten:
  //         "Senang mengumumkan bahwa saya berhasil menyelesaikan proyek [nama proyek] hari ini! Terima kasih kepada semua yang telah mendukung saya. 💪🎉 #Pencapaian #ProyekSelesai",
  //     userId: 5,
  //     img: NetworkImage("https://picsum.photos/800/400"),
  //     totalKomentar: 0,
  //     totalLike: 5,
  //   ),
  //   Post(
  //     id: 5,
  //     tglDibuat: DateTime.utc(2023, 11, 1, 4, 29),
  //     konten:
  //         "Keindahan alam yang menenangkan. Saya merasa beruntung bisa melihat pemandangan seperti ini. 🏞️❤️ #PemandanganAlam #Kedamaian",
  //     userId: 4,
  //     totalKomentar: 0,
  //     totalLike: 3,
  //   ),
  // ];
  final CollectionReference _postsRef =
      FirebaseFirestore.instance.collection("posts");

  CollectionReference get postsRef {
    return _postsRef;
  }

  // final List<Post> _posts = [];
  // Post? post;

  // UnmodifiableListView get posts {
  //   return UnmodifiableListView(_posts);
  // }

  // int postCount = 0;
  Future<int> get postCount async {
    QuerySnapshot querySnapshot = await _postsRef.get();
    return querySnapshot.size;
  }

  Future<List<Post>> getPosts() async {
    QuerySnapshot querySnapshot = await _postsRef.get();
    var documents = querySnapshot.docs;
    List<Post> posts = [];
    for (int i = 0; i < documents.length; i++) {
      posts.add(
        Post(
          id: documents[i].get("id"),
          tglDibuat: documents[i].get("tglDibuat").toDate(),
          konten: documents[i].get("konten"),
          userId: documents[i].get("userId"),
        ),
      );
    }
    return posts;
  }

  Future<Post> getPost({int? id, String? idDoc}) async {
    QuerySnapshot querySnapshot = await _postsRef.get();
    var documents = querySnapshot.docs;
    int i = documents
        .indexWhere((post) => post.id == idDoc || post.get("id") == id);

    Post post = Post(
      id: documents[i].get("id"),
      tglDibuat: documents[i].get("tglDibuat").toDate(),
      konten: documents[i].get("konten"),
      userId: documents[i].get("userId"),
    );
    return post;
  }

  // tambahkan post baru
  void addPost(Post post) async {
    int max = 99999999;
    int min = 10000000;
    int randomNumber = Random().nextInt(max - min + 1) + min;

    String? url;
    if (post.img != null) {
      Reference ref =
          FirebaseStorage.instance.ref().child("posts/${randomNumber}.jpg");
      await ref.putFile(File(post.img!));
      url = await ref.getDownloadURL();
    }

    _postsRef.add({
      "id": await postCount + 1,
      "tglDibuat": post.tglDibuat,
      "konten": post.konten,
      "img": url,
      "totalLike": post.totalLike,
      "totalKomentar": post.totalKomentar,
      "userId": post.userId,
    });
    // notifyListeners();
  }

  void updateTotalLikePost(String id, int totalLike) {
    _postsRef.doc(id).update({
      "totalLike": totalLike,
    });
    // notifyListeners();
  }

  void updateTotalKomentarPost(String id, int totalKomentar) {
    _postsRef.doc(id).update({
      "totalKomentar": totalKomentar,
    });
    // notifyListeners();
  }
  // // update post yg sudah ada
  // void updatePost(Post post) {
  //   // post.tog
  //   int index = _postsRef.indexWhere((postCari) => postCari.id == post.id);
  //   if (index >= 0) {
  //     _postsRef[index] = post;
  //   } else {
  //     print("Tidak ditemukan.");
  //   }
  //   notifyListeners();
  // }

  // void deletePost(Post post) {
  //   _postsRef.remove(post);
  //   notifyListeners();
  // }

  // void like(Post post) {
  //   post.like();
  //   notifyListeners();
  // }

  // void unlike(Post post) {
  //   post.unlike();
  //   notifyListeners();
  // }

  // void sortByDateDesc() {
  //   _postsRef.sort((a, b) {
  //     return b.tglDibuat.compareTo(a.tglDibuat);
  //   });
  //   notifyListeners();
  // }

  // void sortByPopularityDesc() {
  //   _postsRef.sort((a, b) {
  //     return (b.totalLike + b.totalKomentar)
  //         .compareTo(a.totalLike + a.totalKomentar);
  //   });
  //   notifyListeners();
  // }

  final List<Post> _followedPosts = [];
  UnmodifiableListView<Post> get followedPosts {
    return UnmodifiableListView(_followedPosts);
  }

  int get followedPostsCount {
    return _followedPosts.length;
  }

  // void addFollowedPosts(int userIdFollowed) {
  //   List<Post> followedPosts =
  //       _postsRef.where((post) => post.userId == userIdFollowed).toList();
  //   for (Post post in followedPosts) {
  //     if (!_followedPosts.contains(post)) {
  //       _followedPosts.add(post);
  //     }
  //   }
  //   notifyListeners();
  // }

  // List<Post> getPostByUser(int userId) {
  //   return _postsRef.where((post) => post.userId == userId).toList();
  // }
}
