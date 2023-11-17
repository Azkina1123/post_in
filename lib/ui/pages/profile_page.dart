part of "pages.dart";

class ProfilePage extends StatelessWidget {
  User user; // profile user yg sedang dilihat

  ProfilePage({super.key, required this.user});

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My profile"),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                alignment: Alignment.topRight,
                padding: EdgeInsets.only(left: 20),
                child: Row(children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user.username),
                      SizedBox(
                        width: 20,
                      ),
                      Text(user.namaLengkap),
                    ],
                  ),
                  // SizedBox(
                  //   width: 100,
                  // ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: Image.network(user.foto).image,
                    ),
                  ),
                ]),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButton(
                          style: Theme.of(context).textButtonTheme.style,
                          onPressed: () {},
                          child: Text("10" + " Following")),
                      SizedBox(
                        width: 20,
                      ),
                      TextButton(
                          style: Theme.of(context).textButtonTheme.style,
                          onPressed: () {},
                          child: Text("10" + " Follower")),
                    ]),
              ),
              DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    TabBar(
                      tabs: const [
                        Tab(text: "Postingan"),
                        Tab(text: "Komentar")
                      ],
                      labelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize:
                            Theme.of(context).textTheme.titleMedium!.fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                      labelPadding: EdgeInsets.only(left: 10, right: 10),
                      dividerColor: Theme.of(context)
                          .colorScheme
                          .tertiary
                          .withOpacity(0.5),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
