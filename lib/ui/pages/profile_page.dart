part of "pages.dart";

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(
    BuildContext context,
  ) {
    UserAcc user = ModalRoute.of(context)!.settings.arguments
        as UserAcc; // profile user yg sedang dilihat

    return Scaffold(
      appBar: AppBar(
        title: Text("My Profile"),
      ),
      body: ListView(
        children: [
          Container(
            width: 500,
            height: 150,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: Image.network(user.sampul!).image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              Container(
                // alignment: Alignment.topRight,
                padding: EdgeInsets.only(left: 20),
                child: Row(children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.username,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize:
                              Theme.of(context).textTheme.titleLarge!.fontSize,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        user.namaLengkap,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize:
                              Theme.of(context).textTheme.titleMedium!.fontSize,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: Image.network(user.foto!).image,
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
                          onPressed: () {
                            Navigator.pushNamed(context, '/follow');
                          },
                          child: Text("10" + " Following")),
                      SizedBox(
                        width: 20,
                      ),
                      TextButton(
                          style: Theme.of(context).textButtonTheme.style,
                          onPressed: () {
                            Navigator.pushNamed(context, '/follow');
                          },
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
