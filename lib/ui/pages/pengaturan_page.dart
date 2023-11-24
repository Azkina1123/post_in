part of "pages.dart";

class PengaturanPage extends StatelessWidget {
  const PengaturanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeModeData = Provider.of<ThemeModeData>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            "Pengaturan",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Username"),
                      Text("Email"),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 95, top: 40),
                  child: Row(
                    children: [
                      Icon(
                        Icons.navigate_next_rounded,
                        size: 30,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "TAMPILAN",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: Theme.of(context).textTheme.titleSmall!.fontSize,
                ),
              ),
              Divider(
                height: 20,
                thickness: 1,
                color: Theme.of(context).colorScheme.secondary,
              ),
              SizedBox(height: 10),
              // Column(
              //   children: [
              //     Row(
              //       children: [
              //         Container(
              //           width: 50,
              //           height: 50,
              //           decoration: BoxDecoration(
              //             shape: BoxShape.circle,
              //             color: Colors.orange,
              //           ),
              //           child: Icon(Icons.phone_android_rounded,
              //               color: Colors.white, size: 30),
              //         ),
              //         SizedBox(width: 10),
              //         Text(
              //           "Default System",
              //           style: TextStyle(
              //             color: Theme.of(context).colorScheme.secondary,
              //             fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
              //           ),
              //         ),
              //       ],
              //     ),
              //     SizedBox(height: 10),
              //     Row(
              //       children: [
              //         Container(
              //           width: 50,
              //           height: 50,
              //           decoration: BoxDecoration(
              //             shape: BoxShape.circle,
              //             color: Colors.orange,
              //           ),
              //           child: Icon(Icons.sunny, color: Colors.white, size: 30),
              //         ),
              //         SizedBox(width: 10),
              //         Text(
              //           "Light Mode",
              //           style: TextStyle(
              //             color: Theme.of(context).colorScheme.secondary,
              //             fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
              //           ),
              //         ),
              //       ],
              //     ),
              //     SizedBox(height: 10),
              //     Row(
              //       children: [
              //         Container(
              //           width: 50,
              //           height: 50,
              //           decoration: BoxDecoration(
              //             shape: BoxShape.circle,
              //             color: Colors.orange,
              //           ),
              //           child: Icon(Icons.nightlight_round,
              //               color: Colors.white, size: 30),
              //         ),
              //         SizedBox(width: 10),
              //         Text(
              //           "Dark Mode",
              //           style: TextStyle(
              //             color: Theme.of(context).colorScheme.secondary,
              //             fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ],
              // ),
              RadioListTile<ThemeMode>(
                          title: Text(
                            "Default System",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          value: ThemeMode.system,
                          groupValue: themeModeData.themeMode,
                          //activeColor: Provider.of<ThemeModeData>(context).buttonColor,
                          onChanged: (ThemeMode? value) {
                            if (value != null) {
                              Provider.of<ThemeModeData>(context, listen: false)
                                  .changeTheme(value);
                            }
                          },
                        ),
                        RadioListTile<ThemeMode>(
                          title: Text(
                            "Light Mode",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          value: ThemeMode.light,
                          groupValue: themeModeData.themeMode,
                          //activeColor: Provider.of<ThemeModeData>(context).buttonColor,
                          onChanged: (ThemeMode? value) {
                            if (value != null) {
                              Provider.of<ThemeModeData>(context, listen: false)
                                  .changeTheme(value);
                            }
                          },
                        ),
                        RadioListTile<ThemeMode>(
                          title: Text(
                            "Dark Mode",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          value: ThemeMode.dark,
                          groupValue: themeModeData.themeMode,
                          //activeColor: Provider.of<ThemeModeData>(context).buttonColor,
                          onChanged: (ThemeMode? value) {
                            if (value != null) {
                              Provider.of<ThemeModeData>(context, listen: false)
                                  .changeTheme(value);
                            }
                          },
                        ),
              SizedBox(height: 20),
              Text(
                "AKUN",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: Theme.of(context).textTheme.titleSmall!.fontSize,
                ),
              ),
              Divider(
                height: 20,
                thickness: 1,
                color: Theme.of(context).colorScheme.secondary,
              ),
              SizedBox(height: 10),
              Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.orange,
                        ),
                        child: Icon(Icons.lock,
                            color: Colors.white, size: 30),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Ubah Password",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.orange,
                        ),
                        child: Icon(Icons.logout_rounded,
                            color: Colors.white, size: 30),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Keluar Akun",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.orange,
                        ),
                        child: Icon(Icons.delete,
                            color: Colors.white, size: 30),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Hapus Akun",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ]),
          )
        ],
      ),
    );
  }
}
