part of "pages.dart";

class PostPage extends StatelessWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    String postId = ModalRoute.of(context)!.settings.arguments as String;
    return Consumer<KomentarData>(builder: (context, komentarData, child) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              _clearSelectedKomentar(context);
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            "Post",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        body: WillPopScope(
          onWillPop: () async {
            _clearSelectedKomentar(context);
            return true;
          },
          child: RefreshIndicator(
            onRefresh: () async {
              Provider.of<PageData>(context, listen: false).refreshPage();
            },
            child: ListView(
              children: [
                // POST ============================================================================
                StreamBuilder<QuerySnapshot>(
                    stream: Provider.of<PostData>(context, listen: false)
                        .postsCollection
                        .where("id", isEqualTo: postId)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        Post post = Post.fromJson(snapshot.data!.docs[0].data()
                            as Map<String, dynamic>);
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PostWidget(
                              post: post,
                            ),
                            // KOMENTAR =======================================================================
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 10, bottom: 10),
                              child: Text(
                                // "Komentar (${komentars.length})",
                                "Komentar (${post.komentars.length})",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),

                            // INPUT KOMENTAR =======================================================================
                            InputKomentar(
                              post: post,
                            ),
                          ],
                        );
                      }
                      return Container(
                        width: width(context),
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator(),
                      );
                    }),

                // DAFTAR KOMENTAR =======================================================================
                FutureBuilder<QuerySnapshot>(
                    future: komentarData.komentarsCollection
                        .where("postId", isEqualTo: postId)
                        .orderBy("tglDibuat", descending: true)
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                          width: width(context),
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasData) {
                        final komentars = snapshot.data!.docs;
                        int komentarCount = komentars.length;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (int i = 0; i < komentarCount; i++)
                              Column(
                                children: [
                                  KomentarWidget(
                                    komentar: Komentar.fromJson(komentars[i]
                                        .data() as Map<String, dynamic>),
                                    postId: postId,
                                  ),
                                  if (i != komentarCount - 1)
                                    Divider(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary
                                          .withOpacity(0.5),
                                      indent: 10,
                                      endIndent: 10,
                                    )
                                  // di post terakhir tidak perlu pembatas -------------------------
                                  else
                                    const SizedBox(
                                      height: 20,
                                    )
                                ],
                              )
                          ],
                        );
                      }

                      return const Text(
                        "Tidak dapat tersambung.",
                        textAlign: TextAlign.center,
                      );
                    })
              ],
            ),
          ),
        ),
      );
    });
  }

  void _clearSelectedKomentar(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    Provider.of<KomentarData>(context, listen: false).resetSelectedKomentar();
  }
}
