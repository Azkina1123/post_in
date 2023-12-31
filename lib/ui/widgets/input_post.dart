part of "widgets.dart";

class InputPost extends StatefulWidget {
  InputPost({super.key});
  @override
  State<InputPost> createState() => _InputPostState();
}

class _InputPostState extends State<InputPost> {
  final TextEditingController _kontenCon = TextEditingController();
  final FocusNode _focus = FocusNode();
  bool _focused = false;
  String? imgPath;

  @override
  void dispose() {
    super.dispose();
    _kontenCon.dispose();
    _focus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: FutureBuilder<UserAcc>(
          future: Provider.of<UserData>(context, listen: false)
              .getUser(FirebaseAuth.instance.currentUser!.uid),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              UserAcc? authUser = snapshot.data!;
              return Column(
                children: [
                  AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    width: width(context),
                    height: _focused ? 120 : 70,
                    padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                    margin: EdgeInsets.only(top: 20),

                    // isian postingan ---------------------------------------------------------
                    child: Focus(
                      // focusNode: _focus,
                      onFocusChange: (hasFocus) {
                        setState(() {
                          _focused = hasFocus;
                        });
                      },
                      child: TextField(
                        focusNode: _focus,
                        autofocus: imgPath != null ? true : false,
                        decoration: InputDecoration(
                          hintText: "Ceritakan kisah Anda hari ini!",
                          icon: AccountButton(
                            image: NetworkImage(authUser.foto ?? ""),
                            onPressed: null,
                          ),
                        ),
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: 5,
                        controller: _kontenCon,
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                  if (_kontenCon.text.isNotEmpty)
                    Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      // alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (imgPath != null)
                            GestureDetector(
                              onLongPress: () {
                                setState(() {
                                  imgPath = null;
                                });
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: FileImage(
                                      File(imgPath!),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _getFromGallery();
                              });
                            },
                            icon: Icon(Icons.image),
                            iconSize: 40,
                          ),
                          ElevatedButton(
                            onPressed: _kontenCon.text.isNotEmpty &&
                                    !isSpace(_kontenCon.text)
                                ? () {
                                    Provider.of<PostData>(context,
                                            listen: false)
                                        .add(
                                      Post(
                                        id: "",
                                        tglDibuat: DateTime.now(),
                                        konten: _kontenCon.text,
                                        userId: authUser.id,
                                        img: imgPath,
                                      ),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: const Text(
                                            "Post berhasil ditambahkan!"),
                                      ),
                                    );
                                    _focus.unfocus();
                                    _kontenCon.clear();
                                  }
                                : null,
                            // style: ,
                            child: Text("Posting"),
                          ),
                        ],
                      ),
                    )
                ],
              );
            }
            return const Text("");
          }),
    );
  }

  void _getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 60,
    );

    if (pickedFile != null) {
      imgPath = pickedFile.path;
      _focus.requestFocus();
    }
  }

  bool isSpace(String str) {
    return str.trim().isEmpty;
  }
}
